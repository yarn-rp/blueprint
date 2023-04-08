import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:integrations_repository/integrations_repository.dart';

part 'projects_cubit.freezed.dart';
part 'projects_state.dart';

/// The [ProjectsCubit] is responsible for managing the state of the projects
/// page.
///
/// Emits the following states:
/// - [ProjectsInitial] - The initial state of the bloc.
/// - [ProjectsLoading] - The state when the bloc is loading the projects.
/// - [ProjectsModifyingProject] - The state when the bloc is modifying a project.
/// - [ProjectsLoaded] - The state when the bloc has loaded the projects.
/// - [ProjectsError] - The state when the bloc has encountered an error.
///
class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._projectRepository)
      : super(const ProjectsState.initial([]));

  /// The subscription to the stream of projects. This is used to cancel the
  /// subscription when the bloc is closed.
  StreamSubscription<Iterable<Project>>? _projectsSubscription;

  Future<void> loadProjects() async {
    if (_projectsSubscription != null) {
      // If the bloc has a subscription to the stream of projects, then it is
      // already with the latest data.
      return;
    }

    emit(const ProjectsState.loading([]));
    try {
      final projects = _projectRepository.getAllProjects();

      _projectsSubscription = projects.listen(
        (projects) {
          if (isClosed) {
            return;
          }
          emit(ProjectsState.loaded(projects));
        },
      );
    } catch (e) {
      emit(ProjectsState.error(state.projects, e.toString()));
    }
  }

  @override
  Future<void> close() {
    _projectsSubscription?.cancel();
    return super.close();
  }

  final IntegrationsRepository _projectRepository;
}
