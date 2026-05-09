import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  const AndroidInitializationSettings android =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
      InitializationSettings(android: android);

  await notifications.initialize(settings);

  final androidPlugin =
      notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    await androidPlugin.requestNotificationsPermission();
  }
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'task_channel',
    'Task Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails details =
      NotificationDetails(android: androidDetails);

  await notifications.show(
    0,
    'Task Reminder',
    'You have pending tasks!',
    details,
  );
}
