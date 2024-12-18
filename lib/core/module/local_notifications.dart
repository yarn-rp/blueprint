import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:local_notifications/local_notifications.dart';

@module
abstract class LocalNotificationsModule {
  @lazySingleton
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin() =>
      FlutterLocalNotificationsPlugin();

  @lazySingleton
  LocalNotifications localNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) =>
      LocalNotifications(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        notificationSchedulesResource: InMemoryNotificationSchedulesResource(),
      )..initialize(
          androidAppIcon: 'mipmap/ic_launcher',
          linuxDefaultActionName: 'Open',
        );
}
