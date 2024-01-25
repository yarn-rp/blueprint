// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Access _$AccessFromJson(Map<String, dynamic> json) => Access(
      userAccessData:
          UserAccessData.fromJson(json['user'] as Map<String, dynamic>),
      platformId: json['platformId'] as String,
    );

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'platformId': instance.platformId,
      'user': instance.userAccessData.toJson(),
    };

UserAccessData _$UserAccessDataFromJson(Map<String, dynamic> json) =>
    UserAccessData(
      email: json['email'] as String?,
      gid: json['gid'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserAccessDataToJson(UserAccessData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'gid': instance.gid,
      'name': instance.name,
    };
