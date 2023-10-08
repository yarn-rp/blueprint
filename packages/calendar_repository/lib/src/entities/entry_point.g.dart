// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
