// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:practice_platform_channel/main.dart';

void main() {
  testWidgets('Platform Channel Demo app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app shows the platform channel demo screen
    expect(find.text('Platform Channel Demo'), findsOneWidget);
    
    // Verify that the main demo components are present
    expect(find.text('Platform Information'), findsOneWidget);
    expect(find.text('Battery Level'), findsOneWidget);
    expect(find.text('Device Information'), findsOneWidget);
    expect(find.text('Real-time Sensor Data'), findsOneWidget);
    expect(find.text('Native Alert Demo'), findsOneWidget);
    
    // Verify that the educational footer is present
    expect(find.text('How Platform Channels Work'), findsOneWidget);
  });
}
