// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      access: Access.fromJson(json['access'] as Map<String, dynamic>),
      startTime: const TimestampConverter().fromJson(json['startTime']),
      endTime: const TimestampConverter().fromJson(json['endTime']),
      subject: json['subject'] as String,
      isAllDay: json['isAllDay'] as bool?,
      attendantStatus:
          $enumDecode(_$AttendantStatusEnumMap, json['attendantStatus']),
      description: json['description'] as String?,
      colorHex: json['colorHex'] as String?,
      organizer: json['organizer'] == null
          ? null
          : User.fromJson(json['organizer'] as Map<String, dynamic>),
      attendees: (json['attendees'] as List<dynamic>?)
          ?.map((e) => UserWithStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      platformLink: json['platformLink'] as String?,
      conferenceData: json['conferenceData'] == null
          ? null
          : ConferenceData.fromJson(
              json['conferenceData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'access': instance.access.toJson(),
      'startTime': _$JsonConverterToJson<dynamic, DateTime>(
          instance.startTime, const TimestampConverter().toJson),
      'endTime': _$JsonConverterToJson<dynamic, DateTime>(
          instance.endTime, const TimestampConverter().toJson),
      'subject': instance.subject,
      'description': instance.description,
      'isAllDay': instance.isAllDay,
      'colorHex': instance.colorHex,
      'organizer': instance.organizer?.toJson(),
      'attendees': instance.attendees?.map((e) => e.toJson()).toList(),
      'platformLink': instance.platformLink,
      'conferenceData': instance.conferenceData?.toJson(),
      'attendantStatus': _$AttendantStatusEnumMap[instance.attendantStatus]!,
    };

const _$AttendantStatusEnumMap = {
  AttendantStatus.accepted: 'accepted',
  AttendantStatus.declined: 'declined',
  AttendantStatus.tentative: 'tentative',
  AttendantStatus.needsAction: 'needsAction',
  AttendantStatus.none: 'none',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
