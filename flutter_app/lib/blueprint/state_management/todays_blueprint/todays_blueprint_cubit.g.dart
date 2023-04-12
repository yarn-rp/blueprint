// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todays_blueprint_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      calendarEvents: (json['calendarEvents'] as List<dynamic>)
          .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialDateTime: DateTime.parse(json['initialDateTime'] as String),
      workingHours: json['workingHours'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'calendarEvents': instance.calendarEvents,
      'initialDateTime': instance.initialDateTime.toIso8601String(),
      'workingHours': instance.workingHours,
      'addedAt': instance.addedAt.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$_Loading _$$_LoadingFromJson(Map<String, dynamic> json) => _$_Loading(
      calendarEvents: (json['calendarEvents'] as List<dynamic>)
          .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialDateTime: DateTime.parse(json['initialDateTime'] as String),
      workingHours: json['workingHours'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LoadingToJson(_$_Loading instance) =>
    <String, dynamic>{
      'calendarEvents': instance.calendarEvents,
      'initialDateTime': instance.initialDateTime.toIso8601String(),
      'workingHours': instance.workingHours,
      'addedAt': instance.addedAt.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$_Loaded _$$_LoadedFromJson(Map<String, dynamic> json) => _$_Loaded(
      calendarEvents: (json['calendarEvents'] as List<dynamic>)
          .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialDateTime: DateTime.parse(json['initialDateTime'] as String),
      workingHours: json['workingHours'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LoadedToJson(_$_Loaded instance) => <String, dynamic>{
      'calendarEvents': instance.calendarEvents,
      'initialDateTime': instance.initialDateTime.toIso8601String(),
      'workingHours': instance.workingHours,
      'addedAt': instance.addedAt.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$_Error _$$_ErrorFromJson(Map<String, dynamic> json) => _$_Error(
      error: json['error'] as String,
      calendarEvents: (json['calendarEvents'] as List<dynamic>)
          .map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      initialDateTime: DateTime.parse(json['initialDateTime'] as String),
      workingHours: json['workingHours'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ErrorToJson(_$_Error instance) => <String, dynamic>{
      'error': instance.error,
      'calendarEvents': instance.calendarEvents,
      'initialDateTime': instance.initialDateTime.toIso8601String(),
      'workingHours': instance.workingHours,
      'addedAt': instance.addedAt.toIso8601String(),
      'runtimeType': instance.$type,
    };
