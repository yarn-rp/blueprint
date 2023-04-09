// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_basic_auth_integration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubBasicAuthIntegration _$GitHubBasicAuthIntegrationFromJson(
        Map<String, dynamic> json) =>
    GitHubBasicAuthIntegration(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$GitHubBasicAuthIntegrationToJson(
        GitHubBasicAuthIntegration instance) =>
    <String, dynamic>{
      'password': instance.password,
      'username': instance.username,
    };
