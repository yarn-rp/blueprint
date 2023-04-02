import 'package:integrations_repository/src/entities/entities.dart';
import 'package:jira_repository/entities/jira_integration.dart';
import 'package:jira_repository/jira_repository.dart';

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
}
