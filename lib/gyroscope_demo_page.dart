import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeDemoPage extends StatefulWidget {
  const GyroscopeDemoPage({super.key});

  @override
  State<GyroscopeDemoPage> createState() => _GyroscopeDemoPageState();
}

class _GyroscopeDemoPageState extends State<GyroscopeDemoPage> {
  GyroscopeEvent? _gyroscopeEvent;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();

    _gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      setState(() {
        _gyroscopeEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gyroscope Demo")),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Gyroscope values",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                "X : ${_gyroscopeEvent?.x.toStringAsFixed(3)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                "Y : ${_gyroscopeEvent?.y.toStringAsFixed(3)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                "Z : ${_gyroscopeEvent?.z.toStringAsFixed(3)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                "Rotate your device to see the gyroscope values change!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 