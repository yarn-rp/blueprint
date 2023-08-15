import 'package:calendar_repository/src/entities/entities.dart';

/// {@template calendar_repository}
/// Repository which manages calendar events.
/// {@endtemplate}
abstract class CalendarRepository<AuthenticationType> {
  /// {@macro calendar_repository}
  const CalendarRepository();

  /// Get all events from the calendar.
  Future<Iterable<Event>> getTodayEvents();

  /// Authenticates with the platform calendar service.
  Future<AuthenticationType> authenticate();
}
