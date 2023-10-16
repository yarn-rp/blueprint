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
      'entryPoints': instance.entryPoints.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
    };
