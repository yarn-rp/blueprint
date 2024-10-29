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
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    required NotificationSchedulesResource notificationSchedulesResource,
  })  : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        _notificationSchedulesResource = notificationSchedulesResource;

  /// The [FlutterLocalNotificationsPlugin] used to schedule notifications.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final BehaviorSubject<LocalNotification?> _receivedNotifications =
      BehaviorSubject();

  final NotificationSchedulesResource _notificationSchedulesResource;

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
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    return _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  NotificationDetails get _defaultNotificationDetails {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
      ),
    );
  }

  /// Updates an already scheduled notification for an specific [dateTime].
  /// This will update both the resource and the native plugin.
  Future<void> _updateNotificationSchedule(
    tz.TZDateTime dateTime,
    LocalNotification notification,
  ) async {
    // Cancel the notification with native plugin.
    await _cancelLocalNotificationWithPlugin(notification.id);

    // Schedule a new notification with the new date.
    await _scheduleLocalNotificationWithPlugin(dateTime, notification);

    // Finally, update the resource with the new date.
    await _notificationSchedulesResource.updateNotificationSchedule(
      dateTime,
      notification.id,
    );
  }

  /// Creates a new notification schedule for a specific [dateTime].
  /// This will schedule the notification with the native plugin and store the
  /// schedule in the resource.
  Future<void> _createNotificationSchedule(
    tz.TZDateTime dateTime,
    LocalNotification notification,
  ) async {
    await _scheduleLocalNotificationWithPlugin(dateTime, notification);

    await _notificationSchedulesResource.storeNotificationSchedule(
      dateTime,
      notification.id,
    );
  }

  /// Handles the scheduling of a local notification. This will check if the
  /// notification is already scheduled and act accordingly, updating or
  /// creating a new schedule. Use the [anticipation] parameter to schedule
  /// the notification with anticipation.
  ///
  /// If the [localDateTime] is in the past, the notification will not be
  /// scheduled.
  Future<void> requestLocalNotificationSchedule({
    required DateTime localDateTime,
    required LocalNotification notification,
    Duration? anticipation,
  }) async {
    final dateTime = tz.TZDateTime.from(localDateTime, tz.local)
        .subtract(anticipation ?? Duration.zero);

    final isNotificationTimePast = localDateTime.isBefore(DateTime.now());

    if (isNotificationTimePast) {
      // If the notification time is in the past, do not schedule it.
      return;
    }

    final isNotificationScheduled = await _notificationSchedulesResource
        .isNotificationScheduled(notification.id);

    return switch (isNotificationScheduled) {
      // If the notification is already scheduled, update it with the new
      // date. This will mean updating both the resource and the native
      // plugin.
      true => _updateNotificationSchedule(dateTime, notification),

      // If the notification is not scheduled, create a new schedule. This
      // will mean scheduling the notification with the native plugin and
      // storing the schedule in the resource.
      false => _createNotificationSchedule(dateTime, notification),
    };
  }

  /// Cancels a notification with the given [id].
  Future<void> _cancelLocalNotificationWithPlugin(int id) =>
      _flutterLocalNotificationsPlugin.cancel(id);

  /// Schedules a notification with the given [dateTime] and [notification].
  Future<void> _scheduleLocalNotificationWithPlugin(
    tz.TZDateTime dateTime,
    LocalNotification notification,
  ) =>
      _flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.description,
        dateTime,
        _defaultNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
