import 'package:calendar_repository/src/entities/entities.dart';
import 'package:calendar_repository/src/service/calendar_service.dart';
import 'package:local_integrations_repository/local_integrations_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// {@template calendar_repository}
/// Repository which manages calendar events of the same Type.
/// This repository can be used to manage multiple calendars of the same
/// platform, for example, multiple Google calendars.
/// {@endtemplate}
class CalendarRepository
    extends IntegrationsRepository<CalendarPlatform, CalendarService> {
  /// {@macro calendar_repository}
  CalendarRepository({
    required List<CalendarService> services,
  }) : super(services: services);

  /// Get all events of the day from the calendars managed by this repository.
  Stream<Iterable<Event>> getTodayEvents() {
    final servicesTodayEvents = services.map(
      (e) => e.getTodayEvents(),
    );

    return servicesTodayEvents.reduce(
      (previous, current) => previous.combineLatest(
        current,
        (a, b) => [...a, ...b],
      ),
    );
  }
}
