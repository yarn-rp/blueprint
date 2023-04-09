import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

part 'tasks_cubit.freezed.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._projectRepository) : super(const TasksState.initial([]));

  /// The subscription to the stream of Tasks. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<Iterable<Task>>? _tasksSubscription;

  Future<void> loadTasks() async {
    if (_tasksSubscription != null) {
      // If the bloc has a subscription to the stream of Tasks, then it is
      // already with the latest data.
      return;
    }

    emit(const TasksLoading([]));
    try {
      final tasksStream = _projectRepository.getAllTasksRelatedToMe();

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

  final IntegrationsRepository _projectRepository;
}
