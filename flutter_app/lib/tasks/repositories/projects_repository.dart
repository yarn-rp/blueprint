import 'dart:developer';

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
    if (integration is JiraIntegration) {
      return getProjectsFromJiraIntegration(integration);
    }
    //TODO: handle more integrations
    throw Exception('Unsupported integration');
  }

  @visibleForTesting
  Future<List<Project>> getProjectsFromJiraIntegration(
    JiraIntegration integration,
  ) async {
    if (integration is JiraBasicAuthIntegration) {
      return getProjectsFromJiraBasicAuthIntegration(integration);
    }
    if (integration is JiraOAuthIntegration) {
      return getProjectsFromJiraOAuthIntegration(integration);
    }
    throw Exception('Unsupported Jira integration');
  }

  Future<List<Project>> getProjectsFromJiraOAuthIntegration(
    JiraOAuthIntegration integration,
  ) {
    throw UnimplementedError();
  }

  @visibleForTesting
  Future<List<Project>> getProjectsFromJiraBasicAuthIntegration(
    JiraBasicAuthIntegration integration,
  ) async {
    final user = integration.username;
    final apiToken = integration.password;
    final url = integration.url;

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

    final projects = Future.wait(
      pageBeanProject.values.map((jiraProject) async {
        final results = await jira.issueSearch.searchForIssuesUsingJql(
          jql: 'project=${jiraProject.id}',
        );
        for (final issue in results.issues) {
          log('issue: ${issue.toJson()}');
        }

        return Mappers.fromJiraApiProjectToProject(jiraProject, integration);
      }).toList(),
    );

    // Close the client to quickly terminate the process
    client.close();
    return projects;
  }
}
