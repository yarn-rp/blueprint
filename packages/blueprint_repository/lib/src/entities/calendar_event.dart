import 'package:calendar_repository/calendar_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_repository/task_repository.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

/// Refers to an event that is displayed in the calendar.
@freezed
class CalendarEvent with _$CalendarEvent {
  // ignore: lines_longer_than_80_chars
  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
  // Private constructor to prevent instantiation.
  const CalendarEvent._();
  const factory CalendarEvent.event({
    required Event event,
    required DateTime startTime,
    required DateTime endTime,
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
