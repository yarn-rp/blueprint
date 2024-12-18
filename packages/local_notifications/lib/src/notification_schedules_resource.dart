import 'dart:collection';

import 'package:timezone/timezone.dart' as tz;

/// {@template scheduled_notifications_resource}
/// An abstract class that defines the interface for managing scheduled
/// notifications.
/// {@endtemplate}
abstract class NotificationSchedulesResource {
  /// {@macro scheduled_notifications_resource}
  ///
  /// Stores a notification schedule for a specific [dateTime] and [id].
  Future<void> storeNotificationSchedule(
    tz.TZDateTime dateTime,
    int id,
  );

  /// {@macro scheduled_notifications_resource}
  ///
  /// Removes a notification schedule identified by the [id].
  Future<void> removeNotificationSchedule(int id);

  /// {@macro scheduled_notifications_resource}
  ///
  /// Removes all notification schedules.
  Future<void> removeAllNotificationSchedules();

  /// {@macro scheduled_notifications_resource}
  ///
  /// Updates a notification schedule for a specific [dateTime] and [id].
  Future<void> updateNotificationSchedule(
    tz.TZDateTime dateTime,
    int id,
  );

  /// {@macro scheduled_notifications_resource}
  ///
  /// Returns a TZDateTime object if a notification is scheduled for the [id].
  /// Returns null if no notification is scheduled for the [id].
  Future<tz.TZDateTime?> getNotificationSchedule(int id);
}

/// {@template in_memory_scheduled_notifications_resource}
/// An implementation of [NotificationSchedulesResource] that stores
/// notification in memory.
/// {@endtemplate}
class InMemoryNotificationSchedulesResource
    extends NotificationSchedulesResource {
  final HashMap<int, tz.TZDateTime> _schedules = HashMap();

  @override
  Future<void> storeNotificationSchedule(tz.TZDateTime dateTime, int id) async {
    _schedules[id] = dateTime;
  }

  @override
  Future<void> removeNotificationSchedule(int id) async {
    _schedules.remove(id);
  }

  @override
  Future<void> removeAllNotificationSchedules() async {
    _schedules.clear();
  }

  @override
  Future<void> updateNotificationSchedule(
    tz.TZDateTime dateTime,
    int id,
  ) async {
    final notificationSchedule = await getNotificationSchedule(id);

    if (notificationSchedule != null) {
      _schedules[id] = dateTime;
    } else {
      throw StateError('Notification schedule with id $id does not exist.');
    }
  }

  @override
  Future<tz.TZDateTime?> getNotificationSchedule(int id) async {
    return _schedules[id];
  }
}
