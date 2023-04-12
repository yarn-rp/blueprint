// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/blueprint/mappers/task_json_mapper.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

/// Refers to an event that is displayed in the calendar.
@freezed
class CalendarEvent with _$CalendarEvent {
  // Private constructor to prevent instantiation.
  const CalendarEvent._();
  const factory CalendarEvent.event({
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
    @Default(false) bool isAllDay,
  }) = GeneralCalendarEvent;

  const factory CalendarEvent.task({
    @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
        required Task task,
    required DateTime startTime,
    required DateTime endTime,
    @Default(false) bool isAllDay,
  }) = TaskCalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  String get subject => map(
        event: (event) => event.subject,
        task: (task) => task.task.title,
      );
}
