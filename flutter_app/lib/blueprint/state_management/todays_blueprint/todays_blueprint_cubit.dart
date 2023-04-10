import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/blueprint/entities/calendar_event.dart';

part 'todays_blueprint_cubit.freezed.dart';
part 'todays_blueprint_state.dart';

final _defaultEvents = <CalendarEvent>[
  // Gym from 12:00 to 2:00
  CalendarEvent(
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
  CalendarEvent(
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

class TodaysBlueprintCubit extends Cubit<TodaysBlueprintState> {
  TodaysBlueprintCubit() : super(TodaysBlueprintState.initial(_defaultEvents));

  void addTaskToTodaysBlueprint(Task task) {
    late Duration estimatedTime;
    if (task.estimatedTime != null) {
      estimatedTime = task.estimatedTime!;
    } else {
      estimatedTime = const Duration(hours: 1);
    }
    final startTime = _findFirstAvailableSpotForTask(task);

    final event = TaskCalendarEvent(
      task: task,
      startTime: startTime,
      estimatedTime: estimatedTime,
    );
    emit(
      TodaysBlueprintState.loaded(
        [...state.calendarEvents, event],
      ),
    );
  }

  void removeTaskFromTodaysBlueprint(Task task) {
    final events = state.calendarEvents;

    final itemsToKeep = events.where((event) {
      if (event is TaskCalendarEvent) {
        return event.task != task;
      }
      return true;
    }).toList();

    emit(
      TodaysBlueprintState.loaded(
        itemsToKeep,
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
}
