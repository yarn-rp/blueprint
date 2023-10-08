// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['platformURL'] as String,
      json['displayName'] as String,
      json['avatarUrl'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'platformURL': instance.platformURL,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };
