import 'package:platform_integration_repository/src/entities/project/project.dart';
import 'package:platform_integration_repository/src/entities/task/status.dart';
import 'package:platform_integration_repository/src/entities/user/user.dart';

/// {@template ticket}
/// A ticket is a task that is assigned to a user
/// It has a title, description, start date, due date, estimated time, logged
/// time, assigned users, creator, isCompleted, status, priority
/// {@endtemplate}
class Task {
  /// {@macro ticket}
  Task({
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

  /// Kick off creation date
  final DateTime createdAt;

  /// Kick off creation date
  final DateTime updatedAt;

  /// Kick off id
  final String id;

  /// Project to which the ticket belongs
  final Project project;

  /// The url of the ticket in the platform
  final Uri taskURL;

  /// Title of the ticket
  final String title;

  /// maybe rich text (markdown || html)
  final String description;

  /// start date of the ticket
  final DateTime? startDate;

  /// due date of the ticket
  final DateTime? dueDate;

  /// estimated time to complete the ticket
  final Duration? estimatedTime;

  /// time logged in the ticket
  final Duration? loggedTime;

  /// assigned users including me
  final List<User> assigned;

  /// creator of the ticket
  final User creator;

  /// is the ticket completed
  final bool isCompleted;

  /// status of the ticket
  final Iterable<Label> labels;

  /// The priority of the ticket
  /// This is an int between 1 and 5. 1 being the highest priority and 5 being
  /// the lowest priority.
  final int priority;
}
