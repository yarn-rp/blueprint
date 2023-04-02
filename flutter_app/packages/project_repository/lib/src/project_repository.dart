import 'package:integrations_repository/integrations_repository.dart';
import 'package:project_repository/project_repository.dart';

/// {@template project_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ProjectRepository {
  /// {@macro project_repository}
  const ProjectRepository(this._integrationsRepository);

  /// An instance of [IntegrationsRepository] to manage integrations.
  final IntegrationsRepository _integrationsRepository;

  /// Returns the stream of all projects that are integrated with the app.
  /// It will ask for integrations and then, for each integration, it will ask
  /// for the projects that are integrated with it.
  Stream<List<Project>> getProjects() {
    final integrations = _integrationsRepository.getIntegrations();

    return integrations.asyncMap((integrations) async {
      final allProjectsFromIntegrations = await Future.wait(
        integrations.map(
          _integrationsRepository.getProjectsFromIntegration,
        ),
      );
      return allProjectsFromIntegrations
          .expand((projects) => projects)
          .toList();
    });
  }

  /// Return all the tasks that are linked to a specific [project].
  Future<List<Task>> getProjectTasks(Project project) {
    return _integrationsRepository.getProjectTasks(project);
  }

  /// Returns all the tasks the user has in the app.
  Stream<List<Task>> getAllMyTasks() =>
      getProjects().asyncMap((projects) async {
        final allTasksFromProjects = await Future.wait(
          projects.map(
            getProjectTasks,
          ),
        );
        return allTasksFromProjects.expand((tasks) => tasks).toList();
      });
}
