import 'package:blueprint/blueprint/mappers/task_json_mapper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

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
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson) String? colorHex,
    @Default(false) bool isAllDay,
  }) = GeneralCalendarEvent;

  const factory CalendarEvent.task({
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
    required Task task,
    required DateTime startTime,
    required DateTime endTime,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson) String? colorHex,
    @Default(false) bool isAllDay,
  }) = TaskCalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  String get subject => map(
        event: (event) => event.subject,
        task: (task) => task.task.title,
      );
}

String? colorFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }
  return json['colorHex'] as String?;
}

Map<String, dynamic>? colorToJson(String? colorHex) {
  if (colorHex == null) {
    return null;
  }
  return {'colorHex': colorHex};
}
