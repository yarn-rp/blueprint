// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      startTime: Event._timestampFromJson(json['startTime'] as Timestamp?),
      endTime: Event._timestampFromJson(json['endTime'] as Timestamp?),
      subject: json['subject'] as String,
      isAllDay: json['isAllDay'] as bool?,
      attendantStatus:
          $enumDecode(_$AttendantStatusEnumMap, json['attendantStatus']),
      description: json['description'] as String?,
      colorHex: json['colorHex'] as String?,
      organizer: json['organizer'] as String?,
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
      'startTime': Event._timestampToJson(instance.startTime),
      'endTime': Event._timestampToJson(instance.endTime),
      'subject': instance.subject,
      'description': instance.description,
      'isAllDay': instance.isAllDay,
      'colorHex': instance.colorHex,
      'organizer': instance.organizer,
      'attendees': instance.attendees
          ?.map((k, e) => MapEntry(k, _$AttendantStatusEnumMap[e]!)),
      'platformLink': instance.platformLink,
      'conferenceData': instance.conferenceData,
      'platform': instance.platform?.toJson(),
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
