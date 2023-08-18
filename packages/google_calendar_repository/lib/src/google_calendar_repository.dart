import 'package:calendar_repository/calendar_repository.dart';
import 'package:googleapis/calendar/v3.dart' as gCalendar;

/// Google Calendar ID for the primary calendar.
const primaryCalendarId = 'primary';

/// {@template google_calendar_repository}
/// Implementation of [CalendarRepository] using Google Calendar API.
/// {@endtemplate}
class GoogleCalendarRepository implements CalendarRepository {
  /// {@macro google_calendar_repository}
  const GoogleCalendarRepository({
    required gCalendar.CalendarApi googleCalendarApi,
  }) : _googleCalendarApi = googleCalendarApi;

  final gCalendar.CalendarApi _googleCalendarApi;

  @override
  Future<Iterable<Event>> getTodayEvents() async {
    final calEvents = await _googleCalendarApi.events.list(
      primaryCalendarId,
      timeMin: DateTime.now().toUtc(),
      timeMax: DateTime.now().add(const Duration(days: 1)).toUtc(),
    );

    return calEvents.items!.map(
      (gEvent) => Event(
        startTime: gEvent.start!.dateTime,
        endTime: gEvent.end!.dateTime,
        subject: gEvent.summary!,
        description: gEvent.description,
        isAllDay: gEvent.start?.dateTime == null,
      ),
    );
  }
}
