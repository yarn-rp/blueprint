// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCalendarRepository extends Mock implements CalendarRepository {}

class _MockBlueprintRepository extends Mock implements BlueprintRepository {}

void main() {
  late CalendarRepository calendarRepository;
  late BlueprintRepository blueprintRepository;

  setUp(() {
    calendarRepository = _MockCalendarRepository();
    blueprintRepository = _MockBlueprintRepository();
  });

  group('BlueprintBloc', () {
    test('initial state is BlueprintInitial', () {
      expect(
        BlueprintBloc(
          calendarRepository: calendarRepository,
          blueprintRepository: blueprintRepository,
        ).state,
        const BlueprintInitial(),
      );
    });

    group('GetBlueprint', () {
      late BlueprintBloc blueprintBloc;

      setUp(() {
        blueprintBloc = BlueprintBloc(
          calendarRepository: calendarRepository,
          blueprintRepository: blueprintRepository,
        );
      });

      blocTest<BlueprintBloc, BlueprintState>(
        'emits [BlueprintLoading, BlueprintNotScheduled] when blueprint is '
        'empty and previous events is empty',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(const GetBlueprint()),
        setUp: () {
          when(() => blueprintRepository.getBlueprint()).thenAnswer(
            (_) => Stream.value([]),
          );
        },
        expect: () => const <BlueprintState>[
          BlueprintNotScheduled(
            events: [],
          ),
        ],
      );

      blocTest<BlueprintBloc, BlueprintState>(
        'emits [BlueprintLoading, BlueprintNotScheduled] with events when '
        'get blueprint is empty and previous state is blueprint not scheduled '
        'with events not empty',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(const GetBlueprint()),
        setUp: () {
          when(() => blueprintRepository.getBlueprint()).thenAnswer(
            (_) => Stream.value([]),
          );
        },
        seed: () => BlueprintNotScheduled(
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
        expect: () => <BlueprintState>[
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
        ],
      );
    });
  });
}
