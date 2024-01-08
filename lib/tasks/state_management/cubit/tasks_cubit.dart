import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._taskRepository) : super(const TasksState()) {
    _loadTasks();
  }

  final TaskRepository _taskRepository;

  /// The subscription to the stream of Tasks. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<Iterable<Task>>? _tasksSubscription;

  Future<void> selectTask(Task task) async {
    emit(state.copyWith(selectedTask: task));
  }

  Future<void> unselectTask() async {
    emit(
      TasksState(
        tasks: state.tasks,
        status: state.status,
        selectedTask: null,
      ),
    );
  }

  /// Subscribe to the stream of Tasks.
  Future<void> _loadTasks() async {
    if (_tasksSubscription != null) {
      // If the bloc has a subscription to the stream of Tasks, then it is
      // already with the latest data.
      return;
    }

    emit(state.copyWith(status: TasksStatus.loading));

    try {
      final tasksStream = _taskRepository.getAllTasksRelatedToMe(
        sortBy: const SortBy(SortField.updatedAt, SortDirection.desc),
      );

      _tasksSubscription = tasksStream.listen(
        (tasks) {
          if (isClosed) {
            return;
          }
          emit(
            state.copyWith(
              tasks: tasks,
              status: TasksStatus.loaded,
              selectedTask: state.selectedTask ?? tasks.firstOrNull,
            ),
          );
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
    return super.close();
  }
}
