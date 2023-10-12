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
      platform: Platform.fromJson(json['platform'] as Map<String, dynamic>),
      attendantStatus:
          $enumDecode(_$AttendantStatusEnumMap, json['attendantStatus']),
      description: json['description'] as String?,
      colorHex: json['colorHex'] as String?,
      organizer: json['organizer'] == null
          ? null
          : User.fromJson(json['organizer'] as Map<String, dynamic>),
      attendees: (json['attendees'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, $enumDecode(_$AttendantStatusEnumMap, e)),
      ),
      platformLink: json['platformLink'] as String?,
      conferenceData: json['conferenceData'] == null
          ? null
          : ConferenceData.fromJson(
              json['conferenceData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'subject': instance.subject,
      'description': instance.description,
      'isAllDay': instance.isAllDay,
      'colorHex': instance.colorHex,
      'organizer': instance.organizer?.toJson(),
      'attendees': instance.attendees
          ?.map((k, e) => MapEntry(k, _$AttendantStatusEnumMap[e]!)),
      'platformLink': instance.platformLink,
      'platform': instance.platform.toJson(),
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
