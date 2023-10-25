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

  final generalCalendarEvent = GeneralCalendarEvent(
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
  );
  final calendarEvent = CalendarEvent.event(
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
  );

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
        'emits [BlueprintNotScheduled] when blueprint is '
        'empty and previous events are empty',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(const BlueprintRequested()),
        setUp: () {
          when(() => blueprintRepository.getBlueprint()).thenAnswer(
            (_) => Stream.value([]),
          );
        },
        expect: () => <BlueprintState>[
          BlueprintNotScheduled(
            events: const [],
          ),
        ],
        verify: (_) {
          verify(() => blueprintRepository.getBlueprint()).called(1);
        },
      );

      blocTest<BlueprintBloc, BlueprintState>(
        'emits [BlueprintNotScheduled] with events when '
        'get blueprint is empty and previous state is BlueprintScheduled '
        'with events not empty',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(const BlueprintRequested()),
        setUp: () {
          when(() => blueprintRepository.getBlueprint()).thenAnswer(
            (_) => Stream.value([]),
          );
        },
        seed: () => BlueprintScheduled(
          items: const [],
          events: [generalCalendarEvent],
        ),
        expect: () => <BlueprintState>[
          BlueprintNotScheduled(
            events: [generalCalendarEvent],
          ),
        ],
        verify: (_) {
          verify(() => blueprintRepository.getBlueprint()).called(1);
        },
      );

      blocTest<BlueprintBloc, BlueprintState>(
        'emits [] when get blueprint is empty and previous '
        'state is BlueprintNotScheduled with events not empty',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(const BlueprintRequested()),
        setUp: () {
          when(() => blueprintRepository.getBlueprint()).thenAnswer(
            (_) => Stream.value([]),
          );
        },
        seed: () => BlueprintNotScheduled(
          events: [generalCalendarEvent],
        ),
        expect: () => <BlueprintState>[],
        verify: (_) {
          verify(() => blueprintRepository.getBlueprint()).called(1);
        },
      );
    });

    group('GetEvents', () {
      late BlueprintBloc blueprintBloc;

      setUp(() {
        blueprintBloc = BlueprintBloc(
          calendarRepository: calendarRepository,
          blueprintRepository: blueprintRepository,
        );
      });
      blocTest<BlueprintBloc, BlueprintState>(
        'emit BlueprintScheduled when triggering EventsRequested Bloc event',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(EventsRequested()),
        setUp: () {
          when(() => calendarRepository.getEvents())
              .thenAnswer((_) => Stream.value([]));
        },
        expect: () => <BlueprintState>[
          BlueprintScheduled(
            items: const [],
            events: const [],
          ),
        ],
        verify: (_) {
          verify(() => calendarRepository.getEvents()).called(1);
        },
      );
    });

    group('Create Blueprint', () {
      late BlueprintBloc blueprintBloc;

      setUp(() {
        blueprintBloc = BlueprintBloc(
          calendarRepository: calendarRepository,
          blueprintRepository: blueprintRepository,
        );
      });

      blocTest<BlueprintBloc, BlueprintState>(
        'Emit [] when saveBlueprints completes successfully',
        build: () => blueprintBloc,
        seed: () => BlueprintNotScheduled(events: [generalCalendarEvent]),
        act: (bloc) => bloc.add(
          BlueprintCreated(
            items: [calendarEvent],
          ),
        ),
        setUp: () {
          when(
            () => blueprintRepository.saveBlueprints([calendarEvent]),
          ).thenAnswer((_) => Future.value());
        },
        expect: () => <BlueprintState>[],
        verify: (_) {
          verify(
            () => blueprintRepository.saveBlueprints(
              [calendarEvent],
            ),
          ).called(1);
        },
      );

      blocTest<BlueprintBloc, BlueprintState>(
        'Emit BlueprintError when createBlueprint completes not successfully ',
        build: () => blueprintBloc,
        act: (bloc) => bloc.add(
          BlueprintCreated(
            items: [calendarEvent],
          ),
        ),
        setUp: () {
          when(
            () => blueprintRepository.saveBlueprints([calendarEvent]),
          ).thenThrow(Exception());
        },
        expect: () => <BlueprintState>[
          BlueprintError(
            error: Exception().toString(),
          ),
        ],
        verify: (_) {
          verify(
            () => blueprintRepository.saveBlueprints(
              [calendarEvent],
            ),
          ).called(1);
        },
      );
    });
  });
}
