// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_basic_auth_integration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JiraBasicAuthIntegration _$JiraBasicAuthIntegrationFromJson(
        Map<String, dynamic> json,) =>
    JiraBasicAuthIntegration(
      username: json['username'] as String,
      password: json['password'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$JiraBasicAuthIntegrationToJson(
        JiraBasicAuthIntegration instance,) =>
    <String, dynamic>{
      'url': instance.url,
      'username': instance.username,
      'password': instance.password,
    };
