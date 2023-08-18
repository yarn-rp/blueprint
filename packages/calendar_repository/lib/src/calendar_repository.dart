import 'package:calendar_repository/src/entities/entities.dart';

/// {@template calendar_repository}
/// Repository which manages calendar events.
/// {@endtemplate}
abstract class CalendarRepository {
  /// {@macro calendar_repository}
  const CalendarRepository();

  /// Get all events from the calendar.
  Future<Iterable<Event>> getTodayEvents();
}
