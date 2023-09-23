import 'package:event_repository/event_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_repository/task_repository.dart';

part 'calendar_event.freezed.dart';

/// Refers to an event that is displayed in the calendar.
@freezed
class CalendarEvent with _$CalendarEvent {
  // Private constructor to prevent instantiation.
  const CalendarEvent._();
  const factory CalendarEvent.event({
    required DateTime startTime,
    required DateTime endTime,
    required Event event,
  }) = GeneralCalendarEvent;

  const factory CalendarEvent.task({
    required Task task,
    required DateTime startTime,
    required DateTime endTime,
    // ignore: invalid_annotation_target
    String? colorHex,
    @Default(false) bool isAllDay,
  }) = TaskCalendarEvent;

  bool get isAllDay => map(
        event: (event) => false,
        task: (task) => task.isAllDay,
      );

  String? get color => map(
        event: (event) => event.event.colorHex,
        task: (task) => task.colorHex,
      );

  String get subject => map(
        event: (event) => event.event.subject,
        task: (task) => task.task.title,
      );
}
