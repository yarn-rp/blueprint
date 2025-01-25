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
      taskURL: Uri.parse(json['taskURL'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: const TimestampNullableConverter().fromJson(json['startDate']),
      dueDate: const TimestampNullableConverter().fromJson(json['dueDate']),
      estimatedTime:
          durationFromSeconds((json['estimatedTime'] as num?)?.toInt()),
      loggedTime: durationFromSeconds((json['loggedTime'] as num?)?.toInt()),
      assigned: (json['assigned'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool,
      labels: (json['labels'] as List<dynamic>)
          .map((e) => Label.fromJson(e as Map<String, dynamic>)),
      priority: (json['priority'] as num).toInt(),
      project: json['project'] == null
          ? null
          : Project.fromJson(json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'access': instance.access.toJson(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'id': instance.id,
      'project': instance.project?.toJson(),
      'taskURL': instance.taskURL.toString(),
      'title': instance.title,
      'description': instance.description,
      'startDate':
          const TimestampNullableConverter().toJson(instance.startDate),
      'dueDate': const TimestampNullableConverter().toJson(instance.dueDate),
      'estimatedTime': durationToSeconds(instance.estimatedTime),
      'loggedTime': durationToSeconds(instance.loggedTime),
      'assigned': instance.assigned.map((e) => e.toJson()).toList(),
      'creator': instance.creator.toJson(),
      'isCompleted': instance.isCompleted,
      'labels': instance.labels.map((e) => e.toJson()).toList(),
      'priority': instance.priority,
    };
