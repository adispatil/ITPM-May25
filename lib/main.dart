import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:local_notification_demo/auth_page.dart';
import 'package:local_notification_demo/home_page.dart';
import 'package:local_notification_demo/service/firebase_message_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALIZE FIREBASE
  await Firebase.initializeApp();

  // INITIALIZE FIREBASE MESSAGING SERVICE
  await FirebaseMessageService().init();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthPage(),
    );
  }
}
