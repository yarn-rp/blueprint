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
    try {
      final calendarApi = await integration.calendarAPI;

      final todayDate = DateTime.now().copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
      );

      final calEvents = await calendarApi.events.list(
        primaryCalendarId,
        timeMin: todayDate.toUtc(),
        timeMax: todayDate.add(const Duration(days: 1)).toUtc(),
      );

      final colors = await calendarApi.colors.get();

      print('Colors :  ${colors.toJson()}');

      return calEvents.items!.map((gEvent) {
        final colorId = gEvent.colorId;
        print('ColorId: $colorId');

        final colorHex = colors.event![colorId]?.background ?? '#000000';
        print('ColorHex: $colorHex');

        /// fetch the color hex given the colorId

        final gEventStart = gEvent.start;
        final gEventEnd = gEvent.end;

        return Event(
          startTime: gEventStart?.dateTime?.toLocal(),
          endTime: gEventEnd?.dateTime?.toLocal(),
          subject: gEvent.summary ?? 'some integration',
          description: gEvent.description,
          isAllDay: gEvent.start?.dateTime == null,
          colorHex: colorHex,
        );
      });
    } catch (e) {
      await deleteIntegration(integration);
      rethrow;
    }
  }
}
