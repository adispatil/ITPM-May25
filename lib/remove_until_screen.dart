import 'package:flutter/material.dart';

class RemoveUntilScreen extends StatelessWidget {
  const RemoveUntilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push and Remove Until')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const RemoveUntilTargetScreen(),
              ),
              (route) => false,
            );
          },
          child: const Text('Remove All and Go to New Screen'),
        ),
      ),
    );
  }
}

class RemoveUntilTargetScreen extends StatelessWidget {
  const RemoveUntilTargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Previous Removed')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Go Back (will exit app)'),
        ),
      ),
    );
  }
} 