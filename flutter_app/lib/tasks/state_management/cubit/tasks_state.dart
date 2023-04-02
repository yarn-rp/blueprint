part of 'tasks_cubit.dart';

@freezed
abstract class TasksState with _$TasksState {
  const factory TasksState.initial(List<Task> tasks) = TasksInitial;
  const factory TasksState.loading(List<Task> tasks) = TasksLoading;
  const factory TasksState.loaded(List<Task> tasks) = TasksLoaded;
  const factory TasksState.error(List<Task> tasks, String message) = TasksError;
}
