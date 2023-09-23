import 'package:calendar_repository/src/entities/entities.dart';
import 'package:calendar_repository/src/service/calendar_service.dart';
import 'package:local_integrations_repository/local_integrations_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// {@template calendar_repository}
/// Repository which manages calendar events of the same Type.
/// This repository can be used to manage multiple calendars of the same
/// platform, for example, multiple Google calendars.
/// {@endtemplate}
class CalendarRepository extends LocalIntegrationsRepository<CalendarPlatform,
    CalendarIntegration, CalendarService> {
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
        (a, b) => [...a, ...b].toList()
          ..removeWhere((element) {
            if (element.isAllDay ?? false) return false;

            // remove not today events
            final today = DateTime.now().copyWith(
              hour: 0,
              minute: 0,
              second: 0,
              millisecond: 0,
            );
            final start = element.startTime!;
            final end = element.endTime!;

            return start.isBefore(today) || end.isBefore(today);
          })
          ..sort((a, b) {
            final aStart = a.startTime;
            final bStart = b.startTime;

            if (aStart == null && bStart == null) {
              return 0;
            } else if (aStart == null) {
              return 1;
            } else if (bStart == null) {
              return -1;
            }

            return aStart.compareTo(bStart);
          }),
      ),
    );
  }
}
