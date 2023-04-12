import 'dart:developer';

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
  TodaysBlueprintCubit()
      : super(
          TodaysBlueprintState.initial(
            calendarEvents: _defaultEvents,
            addedAt: DateTime.now(),
          ),
        );

  void addTaskToTodaysBlueprint(Task task) {
    late Duration estimatedTime;
    if (task.estimatedTime != null) {
      estimatedTime = task.estimatedTime!;
    } else {
      estimatedTime = const Duration(hours: 1);
    }
    final startTime = _findFirstAvailableSpotForTask(task);

    final event = CalendarEvent.task(
      task: task,
      startTime: startTime,
      endTime: startTime.add(estimatedTime),
    );
    emit(
      TodaysBlueprintState.loaded(
        calendarEvents: [...state.calendarEvents, event],
        addedAt: DateTime.now(),
      ),
    );
  }

  void removeTaskFromTodaysBlueprint(Task task) {
    final events = state.calendarEvents;

    final itemsToKeep = events
        .where(
          (event) => event.map(
            event: (event) => true,
            task: (taskEvent) => taskEvent.task != task,
          ),
        )
        .toList();

    emit(
      TodaysBlueprintState.loaded(
        calendarEvents: itemsToKeep,
        addedAt: DateTime.now(),
      ),
    );
  }

  /// Finds the first available place where a task can be scheduled.
  ///
  /// Basically, it finds the first section where task1.endTime +
  /// task.estimatedTime < task2.startTime
  DateTime _findFirstAvailableSpotForTask(
    Task task,
  ) {
    final events = state.calendarEvents;
    final estimatedTime = task.estimatedTime ?? const Duration(hours: 1);

    for (var i = 0; i < events.length; i++) {
      final event = events[i];

      late CalendarEvent nextEvent;

      try {
        nextEvent = events[i + 1];
      } catch (e) {
        return event.endTime;
      }

      if (event.endTime.add(estimatedTime).isBefore(nextEvent.startTime)) {
        return event.endTime;
      }
    }

    return events.last.endTime;
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
        addedAt: DateTime.now(),
      );
    }
    log('fromJson returned: $state');
    return TodaysBlueprintState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TodaysBlueprintState state) => state.toJson();
}
