import 'package:poll_e_task/tasks/domain/entities/entities.dart';

class TaskEntity {
  TaskEntity({
    required this.id,
    required this.project,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.status,
  });

  final String id;
  final Project project;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final TaskStatus status;
}
