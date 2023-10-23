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
            CreateBlueprint(items: []),
            equals(
              CreateBlueprint(items: []),
            ),
          );

          expect(
            CreateBlueprint(
              items: [
                CalendarEvent.event(
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(const Duration(hours: 1)),
                  event: Event(
                    subject: 'name',
                    description: 'description',
                    attendantStatus: AttendantStatus.accepted,
                    isAllDay: false,
                    startTime: DateTime.now(),
                    endTime: DateTime.now().add(const Duration(hours: 1)),
                  ),
                )
              ],
            ),
            isNot(
              equals(
                CreateBlueprint(
                  items: [
                    CalendarEvent.event(
                      startTime: DateTime.now(),
                      endTime: DateTime.now().add(const Duration(hours: 1)),
                      event: Event(
                        subject: 'Another event',
                        description: 'Another description',
                        attendantStatus: AttendantStatus.accepted,
                        isAllDay: false,
                        startTime: DateTime.now(),
                        endTime: DateTime.now().add(const Duration(hours: 1)),
                      ),
                    )
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
