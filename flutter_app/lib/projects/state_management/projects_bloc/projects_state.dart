part of 'projects_bloc.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial(List<Project> projects) = ProjectsInitial;
  const factory ProjectsState.loading(List<Project> projects) = ProjectsLoading;
  const factory ProjectsState.modifyingProject(
    List<Project> projects,
    Project projectModifying,
  ) = ProjectsModifyingProject;
  const factory ProjectsState.loaded(List<Project> projects) = ProjectsLoaded;
  const factory ProjectsState.error(List<Project> projects, String message) =
      ProjectsError;
}
