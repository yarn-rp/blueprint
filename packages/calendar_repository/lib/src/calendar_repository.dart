import 'package:calendar_repository/src/entities/entities.dart';
import 'package:calendar_repository/src/service/calendar_service.dart';
import 'package:integrations_repository/integrations_repository.dart';

/// {@template calendar_repository}
/// Repository which manages calendar events of the same Type.
/// This repository can be used to manage multiple calendars of the same
/// platform, for example, multiple Google calendars.
/// {@endtemplate}
class CalendarRepository
    extends IntegrationsRepository<CalendarPlatform, CalendarService> {
  /// {@macro calendar_repository}
  CalendarRepository(
    List<CalendarService> services,
  ) : super(services: services);

  /// Get all events of the day from the calendars managed by this repository.
  Stream<Iterable<Event>> getTodayEvents() => services.asyncMap(
        (event) async {
          final allEvents = await Future.wait(
            event.map(
              (e) => e.getTodayEvents(),
            ),
          );
          return allEvents.expand((element) => element);
        },
      );
}
