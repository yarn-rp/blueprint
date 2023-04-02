import 'dart:developer';

import 'package:atlassian_apis/jira_platform.dart' as Jira;
import 'package:flutter/foundation.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/entities/jira_integration.dart';
import 'package:jira_repository/mappers/mapper.dart';

/// {@template jira_repository}
/// Repository in charge of managing Jira integrations.
/// {@endtemplate}
class JiraRepository {
  /// {@macro jira_repository}
  const JiraRepository();

  /// Returns a stream of all projects, reacting to project changes.
  Stream<List<Integration>> getJiraIntegrations() {
    return Stream.value(integrations);
  }

  /// Returns all the projects that are linked to a Jira integration.
  Future<List<Project>> getProjectsIntegration(
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

  /// Returns all the projects that are linked to a Jira with OAuth integration.
  Future<List<Project>> getProjectsFromJiraOAuthIntegration(
    JiraOAuthIntegration integration,
  ) {
    throw UnimplementedError();
  }

  /// Returns all the projects that are linked to a Jira with Basic Auth
  /// integration.
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

final List<Integration> integrations = [
  JiraBasicAuthIntegration(
    username: 'yrodriguez@createthrive.com',
    password:
        'ATATT3xFfGF0ROm4PXsExTla0DCAxYJvcyJorJLpfxBsxAzStl0c-VyKiUtxAbQte33JDbymAkBLYVZeyEHiWMAFZPMrM3TzC6-dakF4JXFMfMHRwvxqjbnGVTfWhgGbJGm-GqrYAkb1gALE0iDksLgKDptWSOwmVQeaJcU-Y8ODifK4iQ9Ch2I=7363C57A',
    url: 'zelfio.atlassian.net',
  ),
];
