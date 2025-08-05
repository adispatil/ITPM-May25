import 'dart:async';
import 'package:flutter/material.dart';

class CounterStreamWidget extends StatefulWidget {
  const CounterStreamWidget({super.key});

  @override
  State<CounterStreamWidget> createState() => _CounterStreamWidgetState();
}

class _CounterStreamWidgetState extends State<CounterStreamWidget> {
  late StreamController<int> _counterController;

  @override
  void initState() {
    super.initState();
    // Create a StreamController to manage our stream
    _counterController = StreamController<int>();
    
    // Initialize with 0
    _counterController.add(0);
  }

  @override
  void dispose() {
    // Clean up resources
    _counterController.close();
    super.dispose();
  }

  void _incrementCounter() {
    // Get current value and increment
    _counterController.stream.last.then((currentValue) {
      _counterController.add(currentValue + 1);
    });
  }

  void _resetCounter() {
    // Add 0 to reset the counter
    _counterController.add(0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Explanation card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.stream,
                    size: 48,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'StreamBuilder Demo',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• StreamBuilder automatically rebuilds\n'
                    '• No need for setState() calls\n'
                    '• UI updates when stream emits\n'
                    '• Clean and reactive!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Counter display using StreamBuilder
          StreamBuilder<int>(
            stream: _counterController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade300, width: 2),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 40),
                      SizedBox(height: 8),
                      Text('Error loading counter'),
                    ],
                  ),
                );
              }
              
              if (!snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text('Loading...'),
                    ],
                  ),
                );
              }
              
              final counter = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade300, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Current Count:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$counter',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add),
                label: const Text('Increment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _resetCounter,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 