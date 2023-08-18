// ignore_for_file: prefer_const_constructors

import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_calendar_repository/google_calendar_repository.dart';
import 'package:googleapis/calendar/v3.dart' as gCalendar;
import 'package:mocktail/mocktail.dart';

class _MockGCalendarApi extends Mock implements gCalendar.CalendarApi {}

class MockEventsResource extends Mock implements gCalendar.EventsResource {}

void main() {
  late gCalendar.CalendarApi gCalendarApi;
  late gCalendar.EventsResource eventsResource;
  setUp(() {
    gCalendarApi = _MockGCalendarApi();
    eventsResource = MockEventsResource();
    when(() => gCalendarApi.events).thenReturn(eventsResource);
  });

  group('GoogleCalendarRepository', () {
    test('can be instantiated', () {
      expect(
        GoogleCalendarRepository(
          googleCalendarApi: gCalendarApi,
        ),
        isNotNull,
      );
    });

    group('getTodayEvents', () {
      test('completes with valid events when api returns calendar events', () {
        final gCalendarEvents = gCalendar.Events.fromJson({
          'items': [
            {
              'summary': 'Test event',
              'description': 'Test description',
              'start': {
                'dateTime': '2021-07-01T10:00:00.000Z',
              },
              'end': {
                'dateTime': '2021-07-01T11:00:00.000Z',
              },
            },
          ],
        });

        when(
          () => eventsResource.list(
            primaryCalendarId,
            timeMin: any(named: 'timeMin'),
            timeMax: any(named: 'timeMax'),
          ),
        ).thenAnswer(
          (_) async => gCalendarEvents,
        );

        final googleCalendarRepository = GoogleCalendarRepository(
          googleCalendarApi: gCalendarApi,
        );

        expect(
          googleCalendarRepository.getTodayEvents(),
          completion(
            equals(
              [
                Event(
                  startTime: DateTime.utc(2021, 7, 1, 10),
                  endTime: DateTime.utc(2021, 7, 1, 11),
                  subject: 'Test event',
                  description: 'Test description',
                  isAllDay: false,
                ),
              ],
            ),
          ),
        );
      });

      test('throws when api throws', () {
        when(
          () => eventsResource.list(
            primaryCalendarId,
            timeMin: any(named: 'timeMin'),
            timeMax: any(named: 'timeMax'),
          ),
        ).thenThrow(
          Exception('Test exception'),
        );

        final googleCalendarRepository = GoogleCalendarRepository(
          googleCalendarApi: gCalendarApi,
        );

        expect(
          googleCalendarRepository.getTodayEvents(),
          throwsException,
        );
      });
    });
  });
}
