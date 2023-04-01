import 'package:poll_e_task/tasks/domain/entities/entities.dart';

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
    required this.ticketURL,
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.estimatedTime,
    required this.loggedTime,
    required this.assigned,
    required this.creator,
    required this.isCompleted,
    required this.status,
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
  final Uri ticketURL;

  /// Title of the ticket
  final String title;

  /// maybe rich text (markdown || html)
  final String description;

  /// start date of the ticket
  final DateTime startDate;

  /// due date of the ticket
  final DateTime dueDate;

  /// estimated time to complete the ticket
  final Duration estimatedTime;

  /// time logged in the ticket
  final Duration loggedTime;

  /// assigned users including me
  final List<User> assigned;

  /// creator of the ticket
  final User creator;

  /// is the ticket completed
  final bool isCompleted;

  /// status of the ticket
  final Status status;

  /// The priority of the ticket
  /// This is a double from 0-1, where 0 is the lowest priority and 1 is the
  /// highest
  final double priority;
}
