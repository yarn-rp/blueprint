// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      subject: json['subject'] as String,
      isAllDay: json['isAllDay'] as bool?,
      description: json['description'] as String?,
      colorHex: json['colorHex'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'subject': instance.subject,
      'description': instance.description,
      'isAllDay': instance.isAllDay,
      'colorHex': instance.colorHex,
    };
