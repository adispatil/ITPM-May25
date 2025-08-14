import 'package:flutter/material.dart';
import '../services/platform_channel_service.dart';
import '../widgets/platform_info_card.dart';
import '../widgets/battery_level_card.dart';
import '../widgets/device_info_card.dart';
import '../widgets/arithmetic_operations_card.dart';
import '../widgets/flashlight_card.dart';
import '../widgets/sensor_data_card.dart';
import '../widgets/alert_demo_card.dart';

class PlatformChannelDemoScreen extends StatefulWidget {
  const PlatformChannelDemoScreen({super.key});

  @override
  State<PlatformChannelDemoScreen> createState() => _PlatformChannelDemoScreenState();
}

class _PlatformChannelDemoScreenState extends State<PlatformChannelDemoScreen> {
  String _platformInfo = 'Loading...';
  int _batteryLevel = -1;
  Map<String, dynamic> _deviceInfo = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPlatformInfo();
  }

  Future<void> _loadPlatformInfo() async {
    setState(() => _isLoading = true);
    
    try {
      final platformInfo = await PlatformChannelService.getPlatformInfo();
      final batteryLevel = await PlatformChannelService.getBatteryLevel();
      final deviceInfo = await PlatformChannelService.getDeviceInfo();
      
      setState(() {
        _platformInfo = platformInfo;
        _batteryLevel = batteryLevel;
        _deviceInfo = deviceInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _platformInfo = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadPlatformInfo,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: _isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading platform information...'),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadPlatformInfo,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.power,
                              size: 48,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Platform Channel Demo',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Learn how Flutter communicates with native code',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Platform Info Card
                      PlatformInfoCard(platformInfo: _platformInfo),
                      
                      const SizedBox(height: 16),
                      
                      // Battery Level Card
                      BatteryLevelCard(batteryLevel: _batteryLevel),
                      
                      const SizedBox(height: 16),
                      
                      // Device Info Card
                      DeviceInfoCard(deviceInfo: _deviceInfo),
                      
                      const SizedBox(height: 16),
                      
                      // Arithmetic Operations Card
                      const ArithmeticOperationsCard(),
                      
                      const SizedBox(height: 16),
                      
                      // Flashlight Card
                      const FlashlightCard(),
                      
                      const SizedBox(height: 16),
                      
                      // Sensor Data Card
                      const SensorDataCard(),
                      
                      const SizedBox(height: 16),
                      
                      // Alert Demo Card
                      const AlertDemoCard(),
                      
                      const SizedBox(height: 32),
                      
                      // Educational Footer
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.school,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'How Platform Channels Work',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Platform channels enable Flutter to communicate with native code:\n\n'
                              '• MethodChannel: For one-time method calls (arithmetic, device info, battery, flashlight)\n'
                              '• EventChannel: For continuous data streams (sensor data)\n'
                              '• BasicMessageChannel: For basic message passing\n\n'
                              'This demo shows practical examples of each type, including hardware control (flashlight) and arithmetic operations performed at the native level for better performance.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
