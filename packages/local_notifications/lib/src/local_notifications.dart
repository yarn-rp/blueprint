import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

/// {@template local_notifications}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class LocalNotifications {
  /// {@macro local_notifications}
  LocalNotifications({
    required this.flutterLocalNotificationsPlugin,
  });

  /// The [FlutterLocalNotificationsPlugin] used to schedule notifications.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final BehaviorSubject<LocalNotification?> _receivedNotifications =
      BehaviorSubject();

  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    final notification = LocalNotification(
      id: id,
      title: title ?? '',
      description: body ?? '',
      payload: payload,
    );

    _receivedNotifications.add(notification);
  }

  /// Initialize the notification plugin.
  Future<bool?> initialize({
    required String androidAppIcon,
    required String linuxDefaultActionName,
  }) {
    final initializationSettingsAndroid = AndroidInitializationSettings(
      androidAppIcon,
    );

    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    final initializationSettingsLinux = LinuxInitializationSettings(
      defaultActionName: linuxDefaultActionName,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    return flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  NotificationDetails get _defaultNotificationDetails {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
      ),
    );
  }

  /// Schedule a notification for a specific [dateTime].
  Future<void> scheduleLocalNotification(
    DateTime dateTime,
    LocalNotification notification,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.description,
      tz.TZDateTime.from(dateTime, tz.local),
      _defaultNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
