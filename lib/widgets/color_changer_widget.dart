import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ColorChangerWidget extends StatefulWidget {
  const ColorChangerWidget({super.key});

  @override
  State<ColorChangerWidget> createState() => _ColorChangerWidgetState();
}

class _ColorChangerWidgetState extends State<ColorChangerWidget> {
  Color _currentColor = Colors.blue;
  late StreamController<Color> _colorController;
  late StreamSubscription<Color> _subscription;
  final Random _random = Random();

  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    // Create a StreamController for Color events
    _colorController = StreamController<Color>();
    
    // Listen to color changes
    _subscription = _colorController.stream.listen((color) {
      setState(() {
        _currentColor = color;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _colorController.close();
    super.dispose();
  }

  void _changeToRandomColor() {
    // Add a random color to the stream
    final randomColor = _colors[_random.nextInt(_colors.length)];
    _colorController.add(randomColor);
  }

  void _changeToSpecificColor(Color color) {
    // Add a specific color to the stream
    _colorController.add(color);
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
                    Icons.palette,
                    size: 48,
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Stream Events',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Streams can carry any data type\n'
                    '• Here we stream Color objects\n'
                    '• Each color change is an event\n'
                    '• UI reacts to each event!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Color display
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: _currentColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _currentColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.color_lens,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Current Color: ${_currentColor.value.toRadixString(16).toUpperCase()}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Random color button
          ElevatedButton.icon(
            onPressed: _changeToRandomColor,
            icon: const Icon(Icons.shuffle),
            label: const Text('Random Color'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Color palette
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _colors.map((color) {
              return GestureDetector(
                onTap: () => _changeToSpecificColor(color),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _currentColor == color ? Colors.white : Colors.grey,
                      width: _currentColor == color ? 3 : 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
} 