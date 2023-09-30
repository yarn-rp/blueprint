import 'dart:async';

import 'package:calendar_repository/calendar_repository.dart';
import 'package:google_calendar_service/src/entities/entities.dart';
import 'package:googleapis/calendar/v3.dart' as gCalendar;
import 'package:googleapis/people/v1.dart' as gPeople;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
      tz.initializeTimeZones();
      final utc = tz.UTC;

      final now = tz.TZDateTime.now(utc);
      final midnightUtc = tz.TZDateTime.utc(
        now.year,
        now.month,
        now.day,
      );

      final tomorrowMidnightUtc = midnightUtc.add(const Duration(days: 1));

      final calEvents = await calendarApi.events.list(
        primaryCalendarId,
        timeMin: midnightUtc,
        timeMax: tomorrowMidnightUtc,
      );

      final colors = await calendarApi.colors.get();

      final events = await Future.wait(
        calEvents.items!.map(
          (gEvent) async {
            final colorId = gEvent.colorId;

            final colorHex = colors.event![colorId]?.background;

            final organizer = await _getEventOrganizer(
              integration,
              gEvent,
            );

            final attendees = await _getAttendees(
              integration,
              gEvent,
            );

            final conferenceData = await _getConferenceData(
              integration,
              gEvent,
            );

            final platformLink = gEvent.htmlLink;
            final gEventStart = gEvent.start;
            final gEventEnd = gEvent.end;

            final eventStartLocalDateTime =
                gEventStart?.dateTime?.toLocal().copyWith(
                      year: now.year,
                      day: now.day,
                      month: now.month,
                    );

            final gEventEndLocalDateTime =
                gEventEnd?.dateTime?.toLocal().copyWith(
                      day: now.day,
                      year: now.year,
                      month: now.month,
                    );

            return Event(
              startTime: eventStartLocalDateTime,
              endTime: gEventEndLocalDateTime,
              subject: gEvent.summary ?? 'No title',
              description: gEvent.description,
              isAllDay: gEvent.start?.dateTime == null,
              colorHex: colorHex,
              organizer: organizer,
              attendees: attendees,
              platformLink: platformLink,
              platform: platform,
              conferenceData: conferenceData,
              attendantStatus: AttendantStatus.none,
            );
          },
        ),
      );

      return events;
    } catch (e) {
      await deleteIntegration(integration);
      rethrow;
    }
  }

  /// This method is used to get conference data from Google Calendar events.
  ///
  /// It takes a GoogleCalendarIntegration object and a Google Calendar Event object as parameters.
  /// It returns a Future that resolves to a ConferenceData object or null if the event has no conference data.
  FutureOr<ConferenceData?> _getConferenceData(
    GoogleCalendarIntegration integration,
    gCalendar.Event gEvent,
  ) {
    if (gEvent.conferenceData == null) {
      return null;
    }
    final gConference = gEvent.conferenceData!;

    final entryPoints = (gConference.entryPoints ?? []).map(
      (gEntryPoint) {
        final entryPointType = gEntryPoint.entryPointType;
        final label = gEntryPoint.label;
        final uri = gEntryPoint.uri;

        return EntryPoint(
          entryPointType: entryPointType,
          label: label,
          uri: uri,
        );
      },
    );

    final notes = gConference.notes;

    return ConferenceData(
      entryPoints: entryPoints,
      notes: notes,
    );
  }

  Future<User?> _getEventOrganizer(
    GoogleCalendarIntegration integration,
    gCalendar.Event gEvent,
  ) async {
    final gOrganizer = gEvent.organizer;

    if (gOrganizer == null) return null;

    final gPeople.Person person;
    try {
      person = switch (gOrganizer.self) {
        true => await _getPerson(integration, 'people/me'),
        false || null => await _getPerson(integration, gOrganizer.email!),
      };
    } catch (e) {
      return User(
        'mailto:${gOrganizer.email}',
        gOrganizer.displayName ?? '',
        '',
        gOrganizer.email ?? '',
      );
    }

    return User(
      'mailto:${gOrganizer.email}',
      person.names?.first.displayName ?? '',
      person.photos?.first.url ?? '',
      person.emailAddresses?.first.value ?? '',
    );
  }

  Future<Map<User, AttendantStatus>> _getAttendees(
    GoogleCalendarIntegration integration,
    gCalendar.Event gEvent,
  ) async {
    final gAttendees = gEvent.attendees;

    if (gAttendees == null) return {};

    final attendees = await Future.wait(
      gAttendees.map<Future<({User user, AttendantStatus status})>>(
        (gAttendee) async {
          final gPeople.Person person;

          final status = _getAttendantStatus(
            gAttendee.responseStatus ?? 'none',
          );
          try {
            person =
                await _getPerson(integration, gAttendee.id ?? gAttendee.email!);
          } catch (e) {
            return (
              user: User(
                'mailto:${gAttendee.email}',
                gAttendee.displayName,
                null,
                gAttendee.email,
              ),
              status: status,
            );
          }

          return (
            user: User(
              'mailto:${gAttendee.email}',
              person.names?.first.displayName,
              person.photos?.first.url,
              person.emailAddresses?.first.value,
            ),
            status: status
          );
        },
      ),
    );

    return Map.fromEntries(
      attendees.map(
        (e) => MapEntry(e.user, e.status),
      ),
    );
  }

  AttendantStatus _getAttendantStatus(
    String status,
  ) {
    switch (status) {
      case 'accepted':
        return AttendantStatus.accepted;
      case 'declined':
        return AttendantStatus.declined;
      case 'tentative':
        return AttendantStatus.tentative;
      case 'needsAction':
        return AttendantStatus.needsAction;
      default:
        return AttendantStatus.none;
    }
  }

  Future<gPeople.Person> _getPerson(
    GoogleCalendarIntegration integration,
    String accountId,
  ) async {
    try {
      final peopleApi = await integration.peopleAPI;

      final p = await peopleApi.people.get(
        accountId,
        personFields: 'names,emailAddresses,photos',
      );

      print('Got person ${p.toJson()}');
      return p;
    } catch (e) {
      print('Error getting person $accountId: $e');
      rethrow;
    }
  }
}
