import 'package:flutter/material.dart';

class PassDataScreen extends StatelessWidget {
  const PassDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Passing Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DataReceiverScreen(data: 'Hello from First Screen!'),
              ),
            );
          },
          child: const Text('Send Data to Next Screen'),
        ),
      ),
    );
  }
}

class DataReceiverScreen extends StatelessWidget {
  final String data;
  const DataReceiverScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Received Data')),
      body: Center(
        child: Text(data, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
} 