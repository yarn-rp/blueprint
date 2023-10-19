import 'dart:developer';

import 'package:blueprint/settings/entities/working_calendar.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_repository/task_repository.dart';
import 'package:blueprint_repository/blueprint_repository.dart';

part 'todays_blueprint_cubit.freezed.dart';
part 'todays_blueprint_state.dart';

class TodaysBlueprintCubit extends Cubit<TodaysBlueprintState> {
  TodaysBlueprintCubit({
    required this.workTimes,
    required this.calendarRepository,
  }) : super(
          TodaysBlueprintState.initial(
            calendarEvents: [],
            workTimes: workTimes,
            addedAt: DateTime.now(),
          ),
        ) {
    calendarRepository.getEvents().listen((events) {
      emit(
        TodaysBlueprintState.loaded(
          calendarEvents: events.map<CalendarEvent>((event) {
            return CalendarEvent.event(
              startTime: event.startTime ?? DateTime.now(),
              endTime:
                  event.endTime ?? DateTime.now().add(const Duration(hours: 1)),
              //  event.endTime ??
              event: event,
            );
          }).toList(),
          workTimes: workTimes,
          addedAt: DateTime.now(),
        ),
      );
    });
  }
  final List<WorkTime> workTimes;
  final CalendarRepository calendarRepository;

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
          workTimes: workTimes,
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
        workTimes: workTimes,
        addedAt: DateTime.now(),
      ),
    );
  }

  void addNewCalendarEvent(GeneralCalendarEvent event) {
    final events = state.calendarEvents;

    emit(
      TodaysBlueprintState.loaded(
        calendarEvents: [...events, event],
        workTimes: workTimes,
        addedAt: DateTime.now(),
      ),
    );
  }

  void removeEvent(CalendarEvent calendarEvent) {
    final events = state.calendarEvents;

    final itemsToKeep = events
        .where(
          (event) => event != calendarEvent,
        )
        .toList();

    emit(
      TodaysBlueprintState.loaded(
        calendarEvents: itemsToKeep,
        workTimes: workTimes,
        addedAt: DateTime.now(),
      ),
    );
  }

  DateTime? findAvailableSpot(Duration eventDuration) => workTimes
      .map((workTime) => findAvailableSpotInWorkTime(eventDuration, workTime))
      .firstWhereOrNull((element) => element != null);

  DateTime? findAvailableSpotInWorkTime(
    Duration eventDuration,
    WorkTime workTime,
  ) {
    final dayStart = DateTime.now().copyWith(
      hour: workTime.start.hour,
      minute: workTime.start.minute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    final dayEnd = DateTime.now().copyWith(
      hour: workTime.end.hour,
      minute: workTime.end.minute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

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
        workTimes: workTimes,
        calendarEvents: [
          ...itemsToKeep,
          movedEvent.copyWith(
            startTime: newStartingDate,
            endTime: newEndingDate,
          ),
        ],
        addedAt: DateTime.now(),
      ),
    );
  }
}

class Spot {
  Spot(
    this.start,
    this.end,
  );

  final DateTime start;
  final DateTime end;
}
