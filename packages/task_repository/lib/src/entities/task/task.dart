// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:task_repository/src/entities/access/access.dart';
import 'package:task_repository/src/entities/entities.dart';
import 'package:task_repository/src/utils/timestamp_converter.dart';

part 'task.g.dart';

/// {@template task}
/// A task that is assigned to a user in one of the projects integrated with
/// blueprint.
/// {@endtemplate}
@JsonSerializable()
class Task {
  /// {@macro task}
  Task({
    required this.access,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.project,
    required this.taskURL,
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.estimatedTime,
    required this.loggedTime,
    required this.assigned,
    required this.creator,
    required this.isCompleted,
    required this.labels,
    required this.priority,
  });

  /// Converts a [Map<String, dynamic>] into a [Task].
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Converts a [Task] into a [Map<String, dynamic>].
  /// This method is needed for serialization and deserialization.
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  final Access access;

  /// Kick off creation date
  @TimestampConverter()
  final DateTime createdAt;

  /// Kick off creation date
  @TimestampConverter()
  final DateTime updatedAt;

  /// Kick off id
  final String id;

  /// Project to which the task belongs
  final Project project;

  /// The url of the task in the platform
  final Uri taskURL;

  /// Title of the task
  final String title;

  /// maybe rich text (markdown || html)
  final String description;

  /// start date of the task
  @TimestampConverter()
  final DateTime? startDate;

  /// due date of the task
  @TimestampConverter()
  final DateTime? dueDate;

  /// estimated time to complete the task
  final Duration? estimatedTime;

  /// time logged in the task
  final Duration? loggedTime;

  /// assigned users including me
  final List<User> assigned;

  /// creator of the task
  final User creator;

  /// is the task completed
  final bool isCompleted;

  /// status of the task
  final Iterable<Label> labels;

  /// The priority of the task
  /// This is an int between 1 and 5. 1 being the highest priority and 5 being
  /// the lowest priority.
  final int priority;

  Task copyWith({
    Access? access,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    Project? project,
    Uri? taskURL,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? dueDate,
    Duration? estimatedTime,
    Duration? loggedTime,
    List<User>? assigned,
    User? creator,
    bool? isCompleted,
    Iterable<Label>? labels,
    int? priority,
  }) {
    return Task(
      access: access ?? this.access,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      project: project ?? this.project,
      taskURL: taskURL ?? this.taskURL,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      loggedTime: loggedTime ?? this.loggedTime,
      assigned: assigned ?? this.assigned,
      creator: creator ?? this.creator,
      isCompleted: isCompleted ?? this.isCompleted,
      labels: labels ?? this.labels,
      priority: priority ?? this.priority,
    );
  }
}
