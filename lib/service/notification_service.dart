import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:timezone/data/latest.dart' as timezone;

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  init() {
    AndroidInitializationSettings initializationAndroidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationAndroidSettings,
    );

    _localNotificationsPlugin.initialize(initializationSettings);

    timezone.initializeTimeZones();
  }

  void sendInstantNotification({
    required String title,
    required String description,
    String? payload,
  }) {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "instant_channel",
        "Instant Notification",
        channelDescription: "Notification that appears instantly",
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      description,
      notificationDetails,
      payload: payload,
    );
  }

  void sendScheduledNotification({
    required String title,
    required String body,
    required DateTime dateTime,
  }) {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "scheduled_channel",
        "Scheduled Notification",
        channelDescription: "Notification that appears after some time",
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    _localNotificationsPlugin.zonedSchedule(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      timezone.TZDateTime.from(dateTime, timezone.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // THIS WILL CLEAR ALL NOTIFICATIONS
  void clearAllNotifications() {
    _localNotificationsPlugin.cancelAll();
  }

  // THIS WILL CLEAR THE NOTIFICATION BY ID
  void clearNotificationById({required int id}) {
    _localNotificationsPlugin.cancel(id);
  }
}
