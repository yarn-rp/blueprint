import 'package:integrations_repository/src/entities/entities.dart';
import 'package:jira_repository/jira_repository.dart';
import 'package:project_repository/project_repository.dart';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  const IntegrationsRepository(this.jiraRepository);

  /// An instance of [JiraRepository] to manage Jira integrations.
  final JiraRepository jiraRepository;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<List<Integration>> getIntegrations() {
    final jiraIntegrations = jiraRepository.getJiraIntegrations();

    return jiraIntegrations;
  }

  /// Returns all the projects that are linked to an specific [integration].
  Future<List<Project>> getProjectsFromIntegration(Integration integration) {
    if (integration is JiraIntegration) {
      return jiraRepository.getProjectsIntegration(integration);
    }
    //TODO: handle more integrations
    throw Exception('Unsupported integration');
  }

  /// Returns all the tasks that are linked to an specific [project].
  Future<List<Task>> getProjectTasks(Project project) {
    if (project.integration is JiraIntegration) {
      return jiraRepository.getProjectTasks(project);
    }
    throw Exception('Unsupported integration');
  }

  /// Adds a new [integration] to the repository.
  Future<void> addIntegration(Integration integration) {
    if (integration is JiraIntegration) {
      return jiraRepository.addJiraIntegration(integration);
    }
    throw Exception('Unsupported integration');
  }
}
