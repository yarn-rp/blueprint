import 'package:atlassian_apis/jira_platform.dart' as Jira;
import 'package:flutter/material.dart';
import 'package:poll_e_task/integrations/entities/integration.dart';
import 'package:poll_e_task/integrations/repositories/integration_repositories.dart';
import 'package:poll_e_task/tasks/entities/entities.dart';
import 'package:poll_e_task/tasks/mappers/mapper.dart';

/// {@template project_repository}
/// A repository that manages projects.
/// {@endtemplate}
class ProjectRepository {
  /// {@macro project_repository}
  ProjectRepository(this.integrationRepository);

  final IntegrationRepository integrationRepository;

  /// Returns a stream of all projects, reacting to project changes.
  Stream<List<Project>> getProjects() {
    final integrations = integrationRepository.getIntegrations();

    final projectsFromIntegrations = integrations.asyncExpand((integrations) {
      final projectsFromIntegration =
          integrations.map(getProjectsFromIntegration);

      return Stream.fromFutures(projectsFromIntegration);
    });

    return projectsFromIntegrations;
  }

  Future<List<Project>> getProjectsFromIntegration(Integration integration) {
    if (integration is JiraBasicAuthIntegration) {
      return getProjectsFromJiraIntegration(integration);
    }
    //TODO: handle more integrations
    throw Exception('Unsupported integration');
  }

  @visibleForTesting
  Future<List<Project>> getProjectsFromJiraIntegration(
    JiraBasicAuthIntegration integration,
  ) async {
    try {
      // This example uses API Token authentication.
      // Alternatively, you can use OAuth.
      final user = integration.username;
      final apiToken = integration.password;
      final url = integration.url;

      print('user: $user');
      print('apiToken: $apiToken');
      print('url: $url');

      // Create an authenticated http client.
      final client = Jira.ApiClient.basicAuthentication(
        Uri.https(url, ''),
        user: user,
        apiToken: apiToken,
      );

      // Create the API wrapper from the http client
      final jira = Jira.JiraPlatformApi(client);

      // Communicate with the APIs..
      final pageBeanProject = await jira.projects.searchProjects();

      final projects = pageBeanProject.values
          .map(Mappers.fromJiraApiProjectToProject)
          .toList();

      // Close the client to quickly terminate the process
      client.close();
      return projects;
    } catch (e, stackTrace) {
      print('error $e, $stackTrace');
      rethrow;
    }
  }
}
