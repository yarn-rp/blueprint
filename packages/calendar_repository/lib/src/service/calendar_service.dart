import 'package:calendar_repository/src/entities/entities.dart';
import 'package:integrations_repository/integrations_repository.dart';

/// {@template calendar_service}
/// Service which manages calendar events.
/// {@endtemplate}
abstract class CalendarService<CalendarPlatformType extends CalendarPlatform,
        CalendarIntegrationType extends Integration<CalendarPlatformType>>
    extends PlatformIntegrationService<CalendarPlatformType,
        CalendarIntegrationType> {
  /// {@macro calendar_service}
  CalendarService({
    required super.platform,
    required super.platformIntegrationStorage,
  });

  /// Get all events from the calendar.
  Future<Iterable<Event>> getTodayEvents();
}
