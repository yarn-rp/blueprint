import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';
import 'package:uuid/uuid.dart';

part 'blueprint_event.dart';
part 'blueprint_state.dart';

const uuid = Uuid();

class BlueprintBloc extends Bloc<BlueprintEvent, BlueprintState> {
  BlueprintBloc({
    required BlueprintRepository blueprintRepository,
  })  : _blueprintRepository = blueprintRepository,
        super(const BlueprintState()) {
    on<BlueprintRequested>(_onGetBlueprint);
    on<CalendarEventCreated>(_onCalendarEventCreated);
    on<EventDeleted>(_onEventDeleted);
    on<EventUpdated>(_onEventUpdated);
  }

  final BlueprintRepository _blueprintRepository;

  Future<void> _onGetBlueprint(
    BlueprintRequested event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));
    final blueprintStream = _blueprintRepository.getBlueprint();

    return emit.forEach(
      blueprintStream,
      onData: (blueprint) => state.copyWith(
        items: blueprint,
        status: BlueprintStatus.loaded,
      ),
      onError: (error, stackTrace) {
        addError(error, stackTrace);

        return state.copyWith(
          status: BlueprintStatus.error,
        );
      },
    );
  }

  Future<void> _onCalendarEventCreated(
    CalendarEventCreated event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));
    final id = uuid.v4();

    final newEvent = CalendarEvent.task(
      task: event.task,
      id: id,
      startTime: event.startTime,
      endTime: event.endTime,
    );

    final newBlueprint = [
      ...state.items,
      newEvent,
    ];

    await _blueprintRepository.saveBlueprint(newBlueprint);
  }

  Future<void> _onEventUpdated(
    EventUpdated event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));

    final newBlueprint =
        state.items.where((element) => element.id != event.event.id).toList();

    await _blueprintRepository.saveBlueprint([
      ...newBlueprint,
      event.event.copyWith(
        startTime: event.startTime,
        endTime: event.endTime,
      ),
    ]);
  }

  Future<void> _onEventDeleted(
    EventDeleted event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));

    final newBlueprint = state.items.where((element) {
      return element.id != event.event.id;
    }).toList();

    await _blueprintRepository.saveBlueprint(newBlueprint);
  }
}
