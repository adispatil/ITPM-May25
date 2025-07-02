import 'package:flutter/material.dart';

class NamedRouteScreen extends StatelessWidget {
  const NamedRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Named Routes')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/basic');
          },
          child: const Text('Go to Basic Navigation via Named Route'),
        ),
      ),
    );
  }
} 