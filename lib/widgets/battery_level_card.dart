import 'package:flutter/material.dart';

class BatteryLevelCard extends StatelessWidget {
  final int batteryLevel;

  const BatteryLevelCard({
    super.key,
    required this.batteryLevel,
  });

  Color _getBatteryColor() {
    if (batteryLevel < 0) return Colors.grey;
    if (batteryLevel < 20) return Colors.red;
    if (batteryLevel < 50) return Colors.orange;
    return Colors.green;
  }

  IconData _getBatteryIcon() {
    if (batteryLevel < 0) return Icons.battery_unknown;
    if (batteryLevel < 20) return Icons.battery_alert;
    if (batteryLevel < 50) return Icons.battery_6_bar;
    return Icons.battery_full;
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
              Colors.green[50]!,
              Colors.green[100]!,
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
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.battery_charging_full,
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
                        'Battery Level',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      Text(
                        'Device battery status',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Battery Visual Indicator
            Center(
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: _getBatteryColor(), width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    // Battery level fill
                    if (batteryLevel >= 0)
                      Container(
                        width: (batteryLevel / 100) * 74,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _getBatteryColor(),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    // Battery percentage text
                    Center(
                      child: Text(
                        batteryLevel >= 0 ? '$batteryLevel%' : 'N/A',
                        style: TextStyle(
                          color: batteryLevel >= 0 ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Battery tip
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getBatteryColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getBatteryIcon(),
                      size: 16,
                      color: _getBatteryColor(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      batteryLevel < 0 
                          ? 'Battery level unavailable'
                          : batteryLevel < 20 
                              ? 'Low battery!'
                              : batteryLevel < 50 
                                  ? 'Battery is getting low'
                                  : 'Battery level is good',
                      style: TextStyle(
                        color: _getBatteryColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Colors.green[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Battery level is retrieved using MethodChannel from native Android/iOS APIs',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green[700],
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
