// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      access: Access.fromJson(json['access'] as Map<String, dynamic>),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      id: json['id'] as String,
      project: Project.fromJson(json['project'] as Map<String, dynamic>),
      taskURL: Uri.parse(json['taskURL'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: const TimestampConverter().fromJson(json['startDate']),
      dueDate: const TimestampConverter().fromJson(json['dueDate']),
      estimatedTime: json['estimatedTime'] == null
          ? null
          : Duration(microseconds: json['estimatedTime'] as int),
      loggedTime: json['loggedTime'] == null
          ? null
          : Duration(microseconds: json['loggedTime'] as int),
      assigned: (json['assigned'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool,
      labels: (json['labels'] as List<dynamic>)
          .map((e) => Label.fromJson(e as Map<String, dynamic>)),
      priority: json['priority'] as int,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'access': instance.access.toJson(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'id': instance.id,
      'project': instance.project.toJson(),
      'taskURL': instance.taskURL.toString(),
      'title': instance.title,
      'description': instance.description,
      'startDate': _$JsonConverterToJson<dynamic, DateTime>(
          instance.startDate, const TimestampConverter().toJson),
      'dueDate': _$JsonConverterToJson<dynamic, DateTime>(
          instance.dueDate, const TimestampConverter().toJson),
      'estimatedTime': instance.estimatedTime?.inMicroseconds,
      'loggedTime': instance.loggedTime?.inMicroseconds,
      'assigned': instance.assigned.map((e) => e.toJson()).toList(),
      'creator': instance.creator.toJson(),
      'isCompleted': instance.isCompleted,
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'priority': instance.priority,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
