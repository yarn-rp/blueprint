import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:task_repository/task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(
    this._taskRepository,
    this._integrationsRepository,
  ) : super(const TasksState());

  final TaskRepository _taskRepository;
  final IntegrationsRepository _integrationsRepository;

  /// The subscription to the stream of Tasks. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<Iterable<Task>>? _tasksSubscription;

  /// The subscription to the stream of Platforms. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<Iterable<Platform>>? _platformsSubscription;

  Future<void> selectTask(Task task) async {
    emit(state.copyWith(selectedTask: task));
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _taskRepository.deleteTask(task);
      await unselectTask();
    } catch (error) {
      addError(error);
    }
  }

  Future<void> unselectTask() async {
    emit(
      TasksState(
        tasks: state.tasks,
        status: state.status,
      ),
    );
  }

  Future<void> fetchPlatforms() async {
    if (_platformsSubscription != null) {
      return;
    }

    _platformsSubscription =
        _integrationsRepository.getAllPlatforms().listen((platforms) {
      final selectedPlatform = platforms.firstWhereOrNull(
        (element) => element == state.selectedPlatform,
      );

      emit(
        state.copyWith(
          platforms: platforms,
          selectedPlatform: selectedPlatform,
        ),
      );
    });
  }

  Future<void> fetchTasks({
    String? query,
    SortBy? sortBy,
    Platform? platform,
  }) async {
    emit(
      state.copyWith(
        status: TasksStatus.loading,
        selectedPlatform: platform,
        sortBy: sortBy,
        lastQuery: query,
      ),
    );

    try {
      final tasksStream = _taskRepository.getTasks(
        query: query ?? state.lastQuery,
        sortBy: sortBy ?? state.sortBy,
        platformId: platform?.id ?? state.selectedPlatform?.id,
      );

      _tasksSubscription = tasksStream.listen(
        (tasks) {
          if (isClosed) {
            return;
          }

          final selectedTask = state.selectedTask != null
              ? tasks.firstWhereOrNull(
                  (element) => element.id == state.selectedTask?.id,
                )
              : tasks.firstOrNull;

          final nextState = state.copyWith(
            tasks: tasks,
            status: TasksStatus.loaded,
            selectedTask: selectedTask,
          );

          emit(
            selectedTask == null ? nextState.withoutSelectedTask() : nextState,
          );
        },
        onError: (Object error, Object stackTrace) {
          print('Error fetching tasks: $error at $stackTrace');
          addError(error);
          emit(state.copyWith(status: TasksStatus.error));
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: TasksStatus.error));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    _platformsSubscription?.cancel();
    return super.close();
  }
}
