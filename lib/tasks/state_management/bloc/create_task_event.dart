part of 'create_task_bloc.dart';

sealed class CreateTaskEvent {
  const CreateTaskEvent();
}

class TitleChanged extends CreateTaskEvent {
  const TitleChanged(this.title);

  final String title;
}

class DescriptionChanged extends CreateTaskEvent {
  const DescriptionChanged(this.description);

  final String description;
}

class DueDateChanged extends CreateTaskEvent {
  const DueDateChanged(this.dueDate);

  final DateTime? dueDate;
}

class PriorityChanged extends CreateTaskEvent {
  const PriorityChanged(this.priority);

  final int priority;
}

class EstimatedTimeChanged extends CreateTaskEvent {
  const EstimatedTimeChanged(this.estimatedTime);

  final Duration? estimatedTime;
}

class CreateTaskSubmitted extends CreateTaskEvent {
  const CreateTaskSubmitted();
}
