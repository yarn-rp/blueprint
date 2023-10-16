// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeneralCalendarEventImpl _$$GeneralCalendarEventImplFromJson(
        Map<String, dynamic> json) =>
    _$GeneralCalendarEventImpl(
      event: Event.fromJson(json['event'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$GeneralCalendarEventImplToJson(
        _$GeneralCalendarEventImpl instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$TaskCalendarEventImpl _$$TaskCalendarEventImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskCalendarEventImpl(
      task: Task.fromJson(json['task'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      colorHex: json['colorHex'] as String?,
      isAllDay: json['isAllDay'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskCalendarEventImplToJson(
        _$TaskCalendarEventImpl instance) =>
    <String, dynamic>{
      'task': instance.task.toJson(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'colorHex': instance.colorHex,
      'isAllDay': instance.isAllDay,
      'runtimeType': instance.$type,
    };
