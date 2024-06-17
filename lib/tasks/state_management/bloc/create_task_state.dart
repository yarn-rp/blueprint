part of 'create_task_bloc.dart';

class CreateTaskState extends Equatable {
  const CreateTaskState({
    this.title,
    this.description,
    this.dueDate,
    this.priority,
    this.estimatedTime,
  });

  final String? title;
  final String? description;
  final DateTime? dueDate;
  final int? priority;
  final Duration? estimatedTime;

  bool get isValid =>
      title != null &&
      title!.isNotEmpty &&
      description != null &&
      description!.isNotEmpty;

  CreateTaskState copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    Duration? estimatedTime,
  }) {
    return CreateTaskState(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        dueDate,
        priority,
        estimatedTime,
      ];
}
