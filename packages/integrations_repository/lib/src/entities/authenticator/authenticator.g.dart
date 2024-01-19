// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatorUserData _$AuthenticatorUserDataFromJson(
        Map<String, dynamic> json) =>
    AuthenticatorUserData(
      name: json['name'] as String?,
      email: json['email'] as String?,
      gid: json['gid'] as String?,
    );

Map<String, dynamic> _$AuthenticatorUserDataToJson(
        AuthenticatorUserData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'gid': instance.gid,
    };

Authenticator _$AuthenticatorFromJson(Map<String, dynamic> json) =>
    Authenticator(
      id: json['id'] as String,
      platform: Platform.fromJson(json['platform'] as Map<String, dynamic>),
      userData: AuthenticatorUserData.fromJson(
          json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticatorToJson(Authenticator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'userData': instance.userData,
    };
