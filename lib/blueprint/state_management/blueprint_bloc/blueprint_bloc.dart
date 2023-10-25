import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:equatable/equatable.dart';

part 'blueprint_event.dart';
part 'blueprint_state.dart';

class BlueprintBloc extends Bloc<BlueprintEvent, BlueprintState> {
  BlueprintBloc({
    required CalendarRepository calendarRepository,
    required BlueprintRepository blueprintRepository,
  }) : super(const BlueprintInitial()) {
    _calendarRepository = calendarRepository;
    _blueprintRepository = blueprintRepository;
    on<BlueprintRequested>(_onGetBlueprint);
    on<EventsRequested>(_onGetEvent);
    on<BlueprintCreated>(_onCreateBlueprint);
  }

  late final CalendarRepository _calendarRepository;
  late final BlueprintRepository _blueprintRepository;

  Future<void> _onGetBlueprint(
    BlueprintRequested event,
    Emitter<BlueprintState> emit,
  ) async {
    final blueprintStream = _blueprintRepository.getBlueprint();

    return emit.forEach(
      blueprintStream,
      onData: (blueprint) {
        final previousEvents = switch (state) {
          BlueprintScheduled(events: final events) => events,
          BlueprintNotScheduled(events: final events) => events,
          _ => <GeneralCalendarEvent>[],
        };

        if (blueprint.isEmpty) {
          return BlueprintNotScheduled(events: previousEvents);
        }
        return BlueprintScheduled(items: blueprint, events: previousEvents);
      },
    );
  }

  Future<void> _onGetEvent(
    EventsRequested event,
    Emitter<BlueprintState> emit,
  ) async {
    final eventsStream = _calendarRepository.getEvents();

    return emit.forEach(
      eventsStream,
      onData: (events) {
        final previousBlueprint = switch (state) {
          BlueprintScheduled(items: final items) => items,
          _ => <CalendarEvent>[],
        };

        return BlueprintScheduled(
          items: previousBlueprint,
          events: events.map(
            (event) {
              return GeneralCalendarEvent(
                event: event,
                // TODO(yarn-rp): take the startTime and endTime on backend to
                // make this fields non nullables
                startTime: event.startTime ?? DateTime.now(),
                endTime: event.endTime ??
                    DateTime.now().add(
                      const Duration(hours: 1),
                    ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Future<void> _onCreateBlueprint(
    BlueprintCreated event,
    Emitter<BlueprintState> emit,
  ) async {
    try {
      await _blueprintRepository.saveBlueprints(event.items);
    } catch (exception) {
      emit(BlueprintError(error: exception.toString()));
    }
  }
}
