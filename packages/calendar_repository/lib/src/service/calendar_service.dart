import 'package:calendar_repository/src/entities/entities.dart';

/// {@template calendar_service}
/// Service which manages calendar events.
/// {@endtemplate}
abstract interface class CalendarService {
  /// {@macro calendar_service}
  const CalendarService();

  /// Get all events from the calendar.
  Future<Iterable<Event>> getTodayEvents();
}
