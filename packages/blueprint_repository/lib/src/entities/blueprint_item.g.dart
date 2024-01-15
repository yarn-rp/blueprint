// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blueprint_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventBlueprintItemImpl _$$EventBlueprintItemImplFromJson(
        Map<String, dynamic> json) =>
    _$EventBlueprintItemImpl(
      value: Event.fromJson(json['value'] as Map<String, dynamic>),
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EventBlueprintItemImplToJson(
        _$EventBlueprintItemImpl instance) =>
    <String, dynamic>{
      'value': instance.value.toJson(),
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$TaskBlueprintItemImpl _$$TaskBlueprintItemImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskBlueprintItemImpl(
      value: Task.fromJson(json['value'] as Map<String, dynamic>),
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskBlueprintItemImplToJson(
        _$TaskBlueprintItemImpl instance) =>
    <String, dynamic>{
      'value': instance.value.toJson(),
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'runtimeType': instance.$type,
    };
