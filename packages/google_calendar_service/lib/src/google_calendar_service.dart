import 'package:calendar_repository/calendar_repository.dart';
import 'package:google_calendar_service/src/entities/entities.dart';

/// Google Calendar ID for the primary calendar.
const primaryCalendarId = 'primary';

/// {@template google_calendar_service}
/// Implementation of [CalendarRepository] using Google Calendar API.
/// {@endtemplate}
class GoogleCalendarService
    extends CalendarService<GoogleCalendarPlatform, GoogleCalendarIntegration> {
  /// {@macro google_calendar_service}
  GoogleCalendarService({
    required super.platformIntegrationStorage,
    super.platform = GoogleCalendarPlatform.instance,
  });

  @override
  Stream<Iterable<Event>> getTodayEvents() {
    final integrationsStream = getIntegrations();

    return integrationsStream.asyncMap((integrations) async {
      final todayEventsOfEachIntegration = await Future.wait(
        integrations.map(_getTodayEventsOfIntegration),
      );

      return todayEventsOfEachIntegration.expand((e) => e);
    });
  }

  Future<Iterable<Event>> _getTodayEventsOfIntegration(
    GoogleCalendarIntegration integration,
  ) async {
    final calendarApi = await integration.calendarAPI;

    final calEvents = await calendarApi.events.list(
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
