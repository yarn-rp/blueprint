// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceData _$ConferenceDataFromJson(Map<String, dynamic> json) =>
    ConferenceData(
      entryPoints: (json['entryPoints'] as List<dynamic>)
          .map((e) => EntryPoint.fromJson(e as Map<String, dynamic>)),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ConferenceDataToJson(ConferenceData instance) =>
    <String, dynamic>{
      'entryPoints': instance.entryPoints.toList(),
      'notes': instance.notes,
    };

EntryPoint _$EntryPointFromJson(Map<String, dynamic> json) => EntryPoint(
      entryPointType: json['entryPointType'] as String?,
      label: json['label'] as String?,
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$EntryPointToJson(EntryPoint instance) =>
    <String, dynamic>{
      'entryPointType': instance.entryPointType,
      'label': instance.label,
      'uri': instance.uri,
    };
