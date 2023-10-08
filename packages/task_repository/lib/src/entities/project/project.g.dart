// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as String,
      platformId: json['platformId'] as String,
      platformURL: Uri.parse(json['platformURL'] as String),
      platformName: json['platformName'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      colorHex: json['colorHex'] as String,
      platform: json['platform'] == null
          ? null
          : Platform.fromJson(json['platform'] as Map<String, dynamic>),
      owner: json['owner'] as String?,
      iconUrl: json['iconUrl'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'platformId': instance.platformId,
      'platformURL': instance.platformURL.toString(),
      'platform': instance.platform,
      'platformName': instance.platformName,
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'colorHex': instance.colorHex,
      'owner': instance.owner,
      'slug': instance.slug,
    };
