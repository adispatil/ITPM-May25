import 'package:flutter/material.dart';
import '../services/platform_channel_service.dart';

class FlashlightCard extends StatefulWidget {
  const FlashlightCard({super.key});

  @override
  State<FlashlightCard> createState() => _FlashlightCardState();
}

class _FlashlightCardState extends State<FlashlightCard> {
  bool _isFlashlightOn = false;
  bool _isFlashlightAvailable = false;
  bool _isLoading = false;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _checkFlashlightAvailability();
  }

  Future<void> _checkFlashlightAvailability() async {
    setState(() => _isLoading = true);
    
    try {
      final isAvailable = await PlatformChannelService.isFlashlightAvailable();
      setState(() {
        _isFlashlightAvailable = isAvailable;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isFlashlightAvailable = false;
        _isLoading = false;
        _lastError = 'Error checking availability: $e';
      });
    }
  }

  Future<void> _toggleFlashlight() async {
    if (!_isFlashlightAvailable) return;
    
    setState(() => _isLoading = true);
    
    try {
      final result = await PlatformChannelService.controlFlashlight(!_isFlashlightOn);
      
      if (result['success'] == true) {
        setState(() {
          _isFlashlightOn = !_isFlashlightOn;
          _lastError = null;
          _isLoading = false;
        });
      } else {
        setState(() {
          _lastError = result['error'] ?? 'Failed to control flashlight';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _lastError = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow[50]!,
              Colors.yellow[100]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.flashlight_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device Flashlight Control',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[800],
                        ),
                      ),
                      Text(
                        'Control camera flash using native APIs',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.yellow[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Flashlight Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.yellow[700],
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _isFlashlightAvailable 
                              ? (_isFlashlightOn ? Colors.green[100] : Colors.grey[100])
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _isFlashlightAvailable 
                                ? (_isFlashlightOn ? Colors.green[300]! : Colors.grey[300]!)
                                : Colors.red[300]!,
                          ),
                        ),
                        child: Text(
                          _isFlashlightAvailable 
                              ? (_isFlashlightOn ? 'ON' : 'OFF')
                              : 'UNAVAILABLE',
                          style: TextStyle(
                            color: _isFlashlightAvailable 
                                ? (_isFlashlightOn ? Colors.green[700] : Colors.grey[700])
                                : Colors.red[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  if (_isFlashlightAvailable) ...[
                    Row(
                      children: [
                        Icon(
                          _isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
                          color: _isFlashlightOn ? Colors.yellow[600] : Colors.grey[600],
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _isFlashlightOn 
                                ? 'Flashlight is currently ON'
                                : 'Flashlight is currently OFF',
                            style: TextStyle(
                              color: _isFlashlightOn ? Colors.yellow[700] : Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Icon(
                          Icons.flashlight_off,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Flashlight not available on this device/platform',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Control Buttons
            if (_isFlashlightAvailable) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _toggleFlashlight,
                      icon: _isLoading 
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(_isFlashlightOn ? Icons.flashlight_off : Icons.flashlight_on),
                      label: Text(_isLoading 
                          ? 'Processing...' 
                          : _isFlashlightOn ? 'Turn OFF' : 'Turn ON'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFlashlightOn ? Colors.red[600] : Colors.green[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _checkFlashlightAvailability,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Check Availability'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
            
            // Error Display
            if (_lastError != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red[600],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _lastError!,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Colors.yellow[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Flashlight control uses MethodChannel to access native camera flash APIs. Only available on mobile devices with camera flash hardware.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.yellow[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
