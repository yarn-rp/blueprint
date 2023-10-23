// ignore_for_file: prefer_const_constructors

import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlueprintState', () {
    group('BlueprintInitial', () {
      test('supports value comparison', () {
        expect(BlueprintInitial(), BlueprintInitial());
      });
    });

    group('BlueprintLoading', () {
      test('supports value comparison', () {
        expect(BlueprintLoading(), BlueprintLoading());
      });
    });

    group('BlueprintNotScheduled', () {
      test('support value equality', () {
        expect(
          BlueprintNotScheduled(
            events: [
              GeneralCalendarEvent(
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
              ),
            ],
          ),
          equals(
            BlueprintNotScheduled(
              events: [
                GeneralCalendarEvent(
                  event: Event(
                    subject: 'name',
                    description: 'description',
                    attendantStatus: AttendantStatus.accepted,
                    isAllDay: false,
                    startTime: DateTime(2023),
                    endTime: DateTime(2023).add(const Duration(hours: 1)),
                  ),
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
              ],
            ),
          ),
        );

        expect(
          BlueprintNotScheduled(
            events: [
              GeneralCalendarEvent(
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
              ),
            ],
          ),
          isNot(
            equals(
              BlueprintNotScheduled(
                events: [
                  GeneralCalendarEvent(
                    event: Event(
                      subject: 'Another event',
                      description: 'Another description',
                      attendantStatus: AttendantStatus.accepted,
                      isAllDay: false,
                      startTime: DateTime(2023),
                      endTime: DateTime(2023).add(const Duration(hours: 1)),
                    ),
                    startTime: DateTime(2023),
                    endTime: DateTime(2023).add(const Duration(hours: 1)),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });

    group('BlueprintScheduled', () {
      test('supports value comparison', () {
        expect(
          BlueprintScheduled(
            items: [
              CalendarEvent.event(
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
              )
            ],
            events: [
              GeneralCalendarEvent(
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
              ),
            ],
          ),
          BlueprintScheduled(
            items: [
              CalendarEvent.event(
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
              )
            ],
            events: [
              GeneralCalendarEvent(
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
              ),
            ],
          ),
        );

        expect(
          BlueprintScheduled(
            items: [
              CalendarEvent.event(
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
              )
            ],
            events: [
              GeneralCalendarEvent(
                event: Event(
                  subject: 'name',
                  description: 'description',
                  attendantStatus: AttendantStatus.accepted,
                  isAllDay: false,
                  startTime: DateTime(2023),
                  endTime: DateTime(2023).add(const Duration(hours: 1)),
                ),
                startTime: DateTime(2023),
                endTime: DateTime(2023).add(const Duration(hours: 1)),
              ),
            ],
          ),
          isNot(
            equals(
              BlueprintScheduled(
                items: [
                  CalendarEvent.event(
                    startTime: DateTime(2023),
                    endTime: DateTime(2023).add(const Duration(hours: 1)),
                    event: Event(
                      subject: 'Another event',
                      description: 'Another description',
                      attendantStatus: AttendantStatus.accepted,
                      isAllDay: false,
                      startTime: DateTime(2023),
                      endTime: DateTime(2023).add(const Duration(hours: 1)),
                    ),
                  )
                ],
                events: [
                  GeneralCalendarEvent(
                    event: Event(
                      subject: 'name',
                      description: 'description',
                      attendantStatus: AttendantStatus.accepted,
                      isAllDay: false,
                      startTime: DateTime(2023),
                      endTime: DateTime(2023).add(const Duration(hours: 1)),
                    ),
                    startTime: DateTime(2023),
                    endTime: DateTime(2023).add(const Duration(hours: 1)),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });

    group('BlueprintError', () {
      test('supports value comparison', () {
        expect(
          BlueprintError(
            error: 'error',
          ),
          BlueprintError(
            error: 'error',
          ),
        );

        expect(
          BlueprintError(
            error: 'error',
          ),
          isNot(
            equals(
              BlueprintError(
                error: 'another error',
              ),
            ),
          ),
        );
      });
    });
  });
}
