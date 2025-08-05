import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BarometerDemoPage extends StatefulWidget {
  const BarometerDemoPage({super.key});

  @override
  State<BarometerDemoPage> createState() => _BarometerDemoPageState();
}

class _BarometerDemoPageState extends State<BarometerDemoPage> {
  BarometerEvent? _barometerEvent;
  StreamSubscription<BarometerEvent>? _pressureSubscription;

  @override
  void initState() {
    super.initState();

    _pressureSubscription = barometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen((event) {
      setState(() {
        _barometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _pressureSubscription?.cancel();
    super.dispose();
  }

  String _getPressureDescription(BarometerEvent? barometerEvent) {
    if (barometerEvent == null) return "No data";
    
    double pressure = barometerEvent.pressure;
    if (pressure < 1000) return "Low pressure (stormy weather)";
    if (pressure < 1013) return "Below average pressure";
    if (pressure < 1020) return "Normal pressure";
    if (pressure < 1030) return "Above average pressure";
    return "High pressure (clear weather)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Barometer Demo")),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Atmospheric Pressure",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      "${_barometerEvent?.pressure.toStringAsFixed(2) ?? 'N/A'}",
                      style: TextStyle(
                        fontSize: 36, 
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    Text(
                      "hPa",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Text(
                  _getPressureDescription(_barometerEvent),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Move to different altitudes to see pressure changes!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20.0),
              Text(
                "Note: Pressure decreases with altitude",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 