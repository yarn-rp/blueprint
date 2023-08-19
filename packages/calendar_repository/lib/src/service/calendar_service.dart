import 'package:calendar_repository/src/entities/entities.dart';
import 'package:local_integrations_repository/local_integrations_repository.dart';

/// {@template calendar_service}
/// Service which manages calendar events.
/// {@endtemplate}
abstract class CalendarService<
    CalendarPlatformType extends CalendarPlatform,
    CalendarIntegrationType extends CalendarIntegration<
        CalendarPlatformType>> extends PlatformIntegrationService<
    CalendarPlatformType, CalendarIntegrationType> {
  /// {@macro calendar_service}
  CalendarService({
    required super.platform,
    required super.platformIntegrationStorage,
  });

  /// Get all events from the calendar.
  Stream<Iterable<Event>> getTodayEvents();
}
