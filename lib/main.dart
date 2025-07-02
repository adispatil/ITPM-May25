import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'basic_navigation_screen.dart';
import 'pass_data_screen.dart';
import 'named_route_screen.dart';
import 'return_data_screen.dart';
import 'replacement_screen.dart';
import 'remove_until_screen.dart';
import 'bottom_nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
      routes: {
        '/basic': (context) => const BasicNavigationScreen(),
        '/passData': (context) => const PassDataScreen(),
        '/namedRoute': (context) => const NamedRouteScreen(),
        '/returnData': (context) => const ReturnDataScreen(),
        '/replacement': (context) => const ReplacementScreen(),
        '/removeUntil': (context) => const RemoveUntilScreen(),
        '/bottomNav': (context) => const BottomNavScreen(),
      },
    );
  }
}
