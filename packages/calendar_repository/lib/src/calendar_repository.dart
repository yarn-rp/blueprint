import 'package:calendar_repository/src/entities/entities.dart';
import 'package:calendar_repository/src/service/calendar_service.dart';

/// {@template calendar_repository}
/// Repository which manages calendar events of the same Type.
/// This repository can be used to manage multiple calendars of the same
/// platform, for example, multiple Google calendars.
/// {@endtemplate}
abstract class CalendarRepository<T extends CalendarService> {
  final List<T> _services = [];

  /// Get all calendar services registered on the repository.
  List<T> get services => _services;

  /// Get all events from the calendar.
  Future<Iterable<Event>> getTodayEvents() async {
    final events = await Future.wait(
      _services.map(
        (service) => service.getTodayEvents(),
      ),
    );

    return events.expand((element) => element);
  }

  /// Adds a new calendar service to the available calendars on the repository.
  Future<void> registerNewCalendarService(T calendarService) {
    _services.add(calendarService);
    return Future.value();
  }
}
