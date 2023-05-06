// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneralCalendarEvent _$$GeneralCalendarEventFromJson(
  Map<String, dynamic> json,
) =>
    _$GeneralCalendarEvent(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      subject: json['subject'] as String,
      isAllDay: json['isAllDay'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$GeneralCalendarEventToJson(
  _$GeneralCalendarEvent instance,
) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'subject': instance.subject,
      'isAllDay': instance.isAllDay,
      'runtimeType': instance.$type,
    };

_$TaskCalendarEvent _$$TaskCalendarEventFromJson(Map<String, dynamic> json) =>
    _$TaskCalendarEvent(
      task: TaskJsonMapper.fromJson(json['task'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isAllDay: json['isAllDay'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskCalendarEventToJson(_$TaskCalendarEvent instance) =>
    <String, dynamic>{
      'task': TaskJsonMapper.toJson(instance.task),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'isAllDay': instance.isAllDay,
      'runtimeType': instance.$type,
    };
