import 'package:flutter/material.dart';
import 'widgets/stream_demo_screen.dart';

void main() {
  runApp(const StreamsDemoApp());
}

class StreamsDemoApp extends StatelessWidget {
  const StreamsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Streams Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StreamDemoScreen(),
    );
  }
}
