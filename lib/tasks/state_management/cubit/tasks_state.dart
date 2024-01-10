part of 'tasks_cubit.dart';

enum TasksStatus { initial, loading, loaded, error }

class TasksState extends Equatable {
  const TasksState({
    this.sortBy,
    this.platforms,
    this.selectedPlatform,
    this.tasks = const [],
    this.status = TasksStatus.initial,
    this.selectedTask,
    this.lastQuery,
    this.sortOptions = const [
      SortBy(SortField.priority, SortDirection.asc, 'Priority'),
      SortBy(SortField.dueDate, SortDirection.asc, 'Due Date'),
    ],
  });

  final Iterable<Task> tasks;
  final TasksStatus status;
  final Task? selectedTask;
  final SortBy? sortBy;
  final Iterable<SortBy> sortOptions;
  final Iterable<Platform>? platforms;
  final Platform? selectedPlatform;
  final String? lastQuery;

  TasksState copyWith({
    Iterable<Task>? tasks,
    TasksStatus? status,
    Task? selectedTask,
    SortBy? sortBy,
    Iterable<SortBy>? sortOptions,
    Platform? selectedPlatform,
    Iterable<Platform>? platforms,
    String? lastQuery,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
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
      tasks: tasks,
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
        tasks,
        status,
        selectedTask,
        sortBy,
        platforms,
        selectedPlatform,
        lastQuery,
        sortOptions,
      ];
}
