part of 'projects_bloc.dart';

@freezed
class ProjectsEvent with _$ProjectsEvent {
  const factory ProjectsEvent.loadProjects() = LoadProjects;
  const factory ProjectsEvent.createProject(Project project) = CreateProject;
  const factory ProjectsEvent.updateProject(Project project) = UpdateProject;
  const factory ProjectsEvent.deleteProject(Project project) = DeleteProject;
}
