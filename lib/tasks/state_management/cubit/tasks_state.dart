part of 'tasks_cubit.dart';

enum TasksStatus { initial, loading, loaded, error }

class TasksState extends Equatable {
  const TasksState({
    this.sortBy,
    this.platforms,
    this.selectedPlatform,
    this.todoTasks = const [],
    this.completedTasks = const [],
    this.status = TasksStatus.initial,
    this.selectedTask,
    this.lastQuery,
    this.sortOptions = const [
      SortBy(SortField.priority, SortDirection.asc, 'Priority'),
      SortBy(SortField.dueDate, SortDirection.asc, 'Due Date'),
    ],
  });

  final Iterable<Task> completedTasks;
  final Iterable<Task> todoTasks;
  final TasksStatus status;
  final Task? selectedTask;
  final SortBy? sortBy;
  final Iterable<SortBy> sortOptions;
  final Iterable<Platform>? platforms;
  final Platform? selectedPlatform;
  final String? lastQuery;

  TasksState copyWith({
    Iterable<Task>? completedTasks,
    Iterable<Task>? todoTasks,
    TasksStatus? status,
    Task? selectedTask,
    SortBy? sortBy,
    Iterable<SortBy>? sortOptions,
    Platform? selectedPlatform,
    Iterable<Platform>? platforms,
    String? lastQuery,
  }) {
    return TasksState(
      completedTasks: completedTasks ?? this.completedTasks,
      todoTasks: todoTasks ?? this.todoTasks,
      status: status ?? this.status,
      selectedTask: selectedTask ?? this.selectedTask,
      sortBy: sortBy ?? this.sortBy,
      sortOptions: sortOptions ?? this.sortOptions,
      selectedPlatform: selectedPlatform ?? this.selectedPlatform,
      platforms: platforms ?? this.platforms,
      lastQuery: lastQuery ?? this.lastQuery,
    );
  }

  TasksState withoutSelectedTask() {
    return TasksState(
      completedTasks: completedTasks,
      todoTasks: todoTasks,
      status: status,
      sortBy: sortBy,
      sortOptions: sortOptions,
      selectedPlatform: selectedPlatform,
      platforms: platforms,
      lastQuery: lastQuery,
    );
  }

  @override
  List<Object?> get props => [
        completedTasks,
        todoTasks,
        status,
        selectedTask,
        sortBy,
        platforms,
        selectedPlatform,
        lastQuery,
        sortOptions,
      ];
}
