part of 'projects_cubit.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial(Iterable<Project> projects) =
      ProjectsInitial;
  const factory ProjectsState.loading(Iterable<Project> projects) =
      ProjectsLoading;
  const factory ProjectsState.modifyingProject(
    Iterable<Project> projects,
    Project projectModifying,
  ) = ProjectsModifyingProject;
  const factory ProjectsState.loaded(Iterable<Project> projects) =
      ProjectsLoaded;
  const factory ProjectsState.error(
    Iterable<Project> projects,
    String message,
  ) = ProjectsError;
}
