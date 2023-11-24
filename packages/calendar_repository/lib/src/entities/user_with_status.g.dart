// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_with_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithStatus _$UserWithStatusFromJson(Map<String, dynamic> json) =>
    UserWithStatus(
      User.fromJson(json['user'] as Map<String, dynamic>),
      $enumDecode(_$AttendantStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserWithStatusToJson(UserWithStatus instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'status': _$AttendantStatusEnumMap[instance.status]!,
    };

const _$AttendantStatusEnumMap = {
  AttendantStatus.accepted: 'accepted',
  AttendantStatus.declined: 'declined',
  AttendantStatus.tentative: 'tentative',
  AttendantStatus.needsAction: 'needsAction',
  AttendantStatus.none: 'none',
};
