part of 'tasks_cubit.dart';

@freezed
abstract class TasksState with _$TasksState {
  const factory TasksState.initial(Iterable<Task> tasks) = TasksInitial;
  const factory TasksState.loading(Iterable<Task> tasks) = TasksLoading;
  const factory TasksState.loaded(Iterable<Task> tasks) = TasksLoaded;
  const factory TasksState.error(Iterable<Task> tasks, String message) =
      TasksError;
}
