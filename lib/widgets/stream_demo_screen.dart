import 'package:flutter/material.dart';
import 'counter_stream_widget.dart';
import 'color_changer_widget.dart';
import 'message_stream_widget.dart';
import 'timer_stream_widget.dart';

class StreamDemoScreen extends StatefulWidget {
  const StreamDemoScreen({super.key});

  @override
  State<StreamDemoScreen> createState() => _StreamDemoScreenState();
}

class _StreamDemoScreenState extends State<StreamDemoScreen> {
  int _currentIndex = 0;

  final List<Widget> _demoWidgets = [
    const CounterStreamWidget(),
    const ColorChangerWidget(),
    const MessageStreamWidget(),
    const TimerStreamWidget(),
  ];

  final List<String> _demoTitles = [
    'Counter Stream',
    'Color Changer',
    'Message Stream',
    'Timer Stream',
  ];

  final List<String> _demoDescriptions = [
    'Simple counter that updates using streams',
    'Change colors with stream events',
    'Send and receive messages through streams',
    'Timer that counts using streams',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Streams Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Header with description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              children: [
                Text(
                  _demoTitles[_currentIndex],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _demoDescriptions[_currentIndex],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          
          // Demo content
          Expanded(
            child: _demoWidgets[_currentIndex],
          ),
          
          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0
                      ? () => setState(() => _currentIndex--)
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                ),
                ElevatedButton.icon(
                  onPressed: _currentIndex < _demoWidgets.length - 1
                      ? () => setState(() => _currentIndex++)
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 