part of 'tasks_cubit.dart';

enum TasksStatus { initial, loading, loaded, error }

class TasksState extends Equatable {
  const TasksState({
    this.tasks = const [],
    this.status = TasksStatus.initial,
    this.selectedTask,
  });

  final Iterable<Task> tasks;
  final TasksStatus status;
  final Task? selectedTask;

  TasksState copyWith({
    Iterable<Task>? tasks,
    TasksStatus? status,
    Task? selectedTask,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      selectedTask: selectedTask ?? this.selectedTask,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        status,
        selectedTask,
      ];
}
