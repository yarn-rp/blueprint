import 'package:poll_e_task/tasks/entities/entities.dart';

/// {@template project_repository}
/// A repository that manages projects.
/// {@endtemplate}
class ProjectRepository {
  /// {@macro project_repository}
  ProjectRepository();

  /// Returns a stream of all projects, reacting to project changes.
  Stream<List<Project>> getProjects() async* {}

  /// Returns a stream of a single project, reacting to project changes.
  Stream<Project> getProject(String id) async* {}

  /// Creates a new project.
  Future<void> createProject(Project project) async {}

  /// Updates a project.
  Future<void> updateProject(Project project) async {}

  /// Deletes a project.
  Future<void> deleteProject(Project id) async {}
}
