import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'todays_blueprint_cubit.freezed.dart';
part 'todays_blueprint_cubit.g.dart';
part 'todays_blueprint_state.dart';

final _defaultEvents = <CalendarEvent>[
  // Gym from 12:00 to 2:00
  CalendarEvent.event(
    subject: 'Gym',
    startTime: DateTime.now().copyWith(
      hour: 12,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    ),
    endTime: DateTime.now().copyWith(
      hour: 14,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    ),
  ),

  // Launch at 2
  CalendarEvent.event(
    subject: 'Launch',
    startTime: DateTime.now().copyWith(
      hour: 14,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    ),
    endTime: DateTime.now().copyWith(
      hour: 15,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    ),
  ),
];

class TodaysBlueprintCubit extends HydratedCubit<TodaysBlueprintState> {
  TodaysBlueprintCubit({
    required this.initialDateTime,
    required this.workingHours,
  }) : super(
          TodaysBlueprintState.initial(
            calendarEvents: _defaultEvents,
            initialDateTime: initialDateTime,
            workingHours: workingHours,
            addedAt: DateTime.now(),
          ),
        );

  final DateTime initialDateTime;
  final int workingHours;

  void addTaskToTodaysBlueprint(Task task) {
    late Duration estimatedTime;
    if (task.estimatedTime != null) {
      estimatedTime = task.estimatedTime!;
    } else {
      estimatedTime = const Duration(hours: 1);
    }

    final startTime = findAvailableSpot(estimatedTime);

    if (startTime == null) {
      log('No available spot for task $task');
      emit(
        TodaysBlueprintState.error(
          error: 'No available spot for task $task',
          calendarEvents: [...state.calendarEvents],
          initialDateTime: initialDateTime,
          workingHours: workingHours,
          addedAt: DateTime.now(),
        ),
      );
      return;
    }

    final event = CalendarEvent.task(
      task: task,
      startTime: startTime,
      endTime: startTime.add(estimatedTime),
    );
    emit(
      TodaysBlueprintState.loaded(
        calendarEvents: [...state.calendarEvents, event],
        initialDateTime: initialDateTime,
        workingHours: workingHours,
        addedAt: DateTime.now(),
      ),
    );
  }

  void removeTaskFromTodaysBlueprint(Task task) {
    final events = state.calendarEvents;
    log('removing task $task');
    final itemsToKeep = events
        .where(
          (event) => event.map(
            event: (event) => true,
            task: (taskEvent) => taskEvent.task.title != task.title,
          ),
        )
        .toList();

    emit(
      TodaysBlueprintState.loaded(
        calendarEvents: itemsToKeep,
        initialDateTime: initialDateTime,
        workingHours: workingHours,
        addedAt: DateTime.now(),
      ),
    );
  }

  DateTime? findAvailableSpot(Duration eventDuration) {
    final dayStart = DateTime.now().isAfter(initialDateTime)
        ? DateTime.now()
        : initialDateTime;

    final dayEnd = dayStart.add(Duration(hours: workingHours));
    // Sort events by start time
    final events = state.calendarEvents
        .sorted((a, b) => a.startTime.compareTo(b.startTime));

    // Check for availability before the first event
    if (events.first.startTime.difference(dayStart) >= eventDuration) {
      return dayStart;
    }

    // Check for availability between events
    for (var i = 0; i < events.length - 1; i++) {
      final gap = events[i + 1].startTime.difference(events[i].endTime);
      if (gap >= eventDuration) {
        return events[i].endTime;
      }
    }

    // Check for availability after the last event
    if (dayEnd.difference(events.last.endTime) >= eventDuration) {
      return events.last.endTime;
    }

    // No available spot found
    return null;
  }

  /// Moves a task in the time line,
  void moveEventInTimeLine(
    CalendarEvent movedEvent,
    DateTime newStartingDate,
    DateTime newEndingDate,
  ) {
    final events = state.calendarEvents;

    final itemsToKeep = events
        .where(
          (event) => event.subject != movedEvent.subject,
        )
        .toList();

    emit(
      TodaysBlueprintState.loaded(
        initialDateTime: initialDateTime,
        workingHours: workingHours,
        calendarEvents: [
          ...itemsToKeep,
          movedEvent.copyWith(
            startTime: newStartingDate,
            endTime: newEndingDate,
          )
        ],
        addedAt: DateTime.now(),
      ),
    );
  }

  @override
  TodaysBlueprintState? fromJson(Map<String, dynamic> json) {
    log('fromJson: $json');
    final state = _$TodaysBlueprintStateFromJson(json);
    if (state.addedAt.day != DateTime.now().day) {
      return TodaysBlueprintState.initial(
        calendarEvents: _defaultEvents,
        initialDateTime: initialDateTime,
        workingHours: workingHours,
        addedAt: DateTime.now(),
      );
    }
    log('fromJson returned: $state');
    return TodaysBlueprintState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TodaysBlueprintState state) => state.toJson();
}

class Spot {
  Spot(
    this.start,
    this.end,
  );

  final DateTime start;
  final DateTime end;
}
