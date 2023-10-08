import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_repository/task_repository.dart';

part 'tasks_cubit.freezed.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._taskRepository) : super(const TasksState.initial([])) {
    _loadTasks();
  }

  final TaskRepository _taskRepository;

  /// The subscription to the stream of Tasks. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<Iterable<Task>>? _tasksSubscription;

  /// Subscribe to the stream of Tasks.
  Future<void> _loadTasks() async {
    if (_tasksSubscription != null) {
      // If the bloc has a subscription to the stream of Tasks, then it is
      // already with the latest data.
      return;
    }

    emit(const TasksLoading([]));
    try {
      final tasksStream = _taskRepository.getAllTasksRelatedToMe();

      _tasksSubscription = tasksStream.listen(
        (tasks) {
          if (isClosed) {
            return;
          }
          emit(
            TasksState.loaded(
              tasks.toList()
                ..sort((a, b) => a.updatedAt.isAfter(b.updatedAt) ? -1 : 1),
            ),
          );
        },
      );
    } catch (e) {
      emit(TasksState.error(state.tasks, e.toString()));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}
