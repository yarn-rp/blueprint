// ignore_for_file: prefer_const_constructors

import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'BlueprintEvent',
    () {
      group('GetBlueprint', () {
        test('supports value equality', () {
          expect(GetBlueprint(), equals(GetBlueprint()));
        });
      });

      group('GetEvents', () {
        test('supports value equality', () {
          expect(GetEvents(), equals(GetEvents()));
        });
      });

      group('CreateBlueprint', () {
        test('supports value equality', () {
          expect(
            CreateBlueprint(
              items: [
                CalendarEvent.event(
                  startTime: DateTime(2023),
                  endTime: DateTime(2023),
                  event: Event(
                    subject: 'name',
                    description: 'description',
                    attendantStatus: AttendantStatus.accepted,
                    isAllDay: false,
                    startTime: DateTime(2023),
                    endTime: DateTime(2023),
                  ),
                ),
              ],
            ),
            equals(
              CreateBlueprint(
                items: [
                  CalendarEvent.event(
                    startTime: DateTime(2023),
                    endTime: DateTime(2023),
                    event: Event(
                      subject: 'name',
                      description: 'description',
                      attendantStatus: AttendantStatus.accepted,
                      isAllDay: false,
                      startTime: DateTime(2023),
                      endTime: DateTime(2023),
                    ),
                  ),
                ],
              ),
            ),
          );

          expect(
            CreateBlueprint(
              items: [
                CalendarEvent.event(
                  startTime: DateTime(2023),
                  endTime: DateTime(2023),
                  event: Event(
                    subject: 'name',
                    description: 'description',
                    attendantStatus: AttendantStatus.accepted,
                    isAllDay: false,
                    startTime: DateTime(2023),
                    endTime: DateTime(2023),
                  ),
                ),
              ],
            ),
            isNot(
              equals(
                CreateBlueprint(
                  items: [
                    CalendarEvent.event(
                      startTime: DateTime(2023),
                      endTime: DateTime(2023, 10, 10),
                      event: Event(
                        subject: 'Another event',
                        description: 'Another description',
                        attendantStatus: AttendantStatus.accepted,
                        isAllDay: false,
                        startTime: DateTime(2023),
                        endTime: DateTime(2023, 10, 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
    },
  );
}
