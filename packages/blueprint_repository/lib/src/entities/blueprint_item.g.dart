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
      startTime: const TimestampConverter().fromJson(json['startTime']),
      endTime: const TimestampConverter().fromJson(json['endTime']),
      isPreview: json['isPreview'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EventBlueprintItemImplToJson(
        _$EventBlueprintItemImpl instance) =>
    <String, dynamic>{
      'value': instance.value.toJson(),
      'id': instance.id,
      'startTime': const TimestampConverter().toJson(instance.startTime),
      'endTime': const TimestampConverter().toJson(instance.endTime),
      'isPreview': instance.isPreview,
      'runtimeType': instance.$type,
    };

_$TaskBlueprintItemImpl _$$TaskBlueprintItemImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskBlueprintItemImpl(
      value: Task.fromJson(json['value'] as Map<String, dynamic>),
      id: json['id'] as String,
      startTime: const TimestampConverter().fromJson(json['startTime']),
      endTime: const TimestampConverter().fromJson(json['endTime']),
      isPreview: json['isPreview'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TaskBlueprintItemImplToJson(
        _$TaskBlueprintItemImpl instance) =>
    <String, dynamic>{
      'value': instance.value.toJson(),
      'id': instance.id,
      'startTime': const TimestampConverter().toJson(instance.startTime),
      'endTime': const TimestampConverter().toJson(instance.endTime),
      'isPreview': instance.isPreview,
      'runtimeType': instance.$type,
    };
