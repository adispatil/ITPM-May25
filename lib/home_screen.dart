import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Navigation Demos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/basic'),
            child: const Text('Basic Navigation (push/pop)'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/passData'),
            child: const Text('Passing Data Between Screens'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/namedRoute'),
            child: const Text('Named Routes'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/returnData'),
            child: const Text('Return Data from Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/replacement'),
            child: const Text('Push Replacement'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/removeUntil'),
            child: const Text('Push and Remove Until'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/bottomNav'),
            child: const Text('Bottom Navigation Bar'),
          ),
        ],
      ),
    );
  }
} 