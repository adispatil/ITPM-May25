import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_notification_demo/service/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('handling background message');
  print(message.notification?.title);
  print(message.notification?.body);
}

class FirebaseMessageService {
  // 1. CREATE PRIVATE INSTANCE
  static final FirebaseMessageService _instance =
      FirebaseMessageService._internal();

  // 2. FACTORY METHOD
  factory FirebaseMessageService() {
    return _instance;
  }

  // 3. CONSTRUCTOR
  FirebaseMessageService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationService _notificationService = NotificationService();

  Future<void> init() async {
    // 1. GET FCM TOKEN
    String? token = await _firebaseMessaging.getToken();
    print("Token : $token");

    // CONFIGURE MESSAGE HANDLING
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    print("Message opened app: ");
    print("Message opened app: ${message.notification?.title}");
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print(message);

    print(message.notification?.title);
    print(message.notification?.body);

    _notificationService.sendInstantNotification(
      title: message.notification?.title ?? '',
      description: message.notification?.body ?? '',
      payload: message.notification?.android?.imageUrl,
    );
  }

  // SUBSCRIBE TO ANY SPECIFIC TOPIC
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // UNSUBSCRIBE TO ANY SPECIFIC TOPIC
  Future<void> unsubscribeToTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();


  }
}
