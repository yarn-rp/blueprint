import 'package:atlassian_apis/jira_platform.dart' as Jira;
import 'package:flutter/foundation.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/entities/jira_integration.dart';
import 'package:jira_repository/mappers/mapper.dart';
import 'package:project_repository/project_repository.dart';

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
        // final results = await jira.issueSearch.searchForIssuesUsingJql(
        //   jql: 'project=${jiraProject.id}',
        // );
        // for (final issue in results.issues) {
        //   log('issue: ${issue.toJson()}');
        // }

        return Mappers.fromJiraApiProjectToProject(jiraProject, integration);
      }).toList(),
    );

    // Close the client to quickly terminate the process
    client.close();
    return projects;
  }

  /// Returns all the tasks that are linked to a jira project.
  Future<List<Task>> getProjectTasks(Project project) {
    if (project.integration is JiraBasicAuthIntegration) {
      return getProjectTasksFromJiraBasicAuthIntegration(project);
    }
    if (project.integration is JiraOAuthIntegration) {
      return getProjectTasksFromJiraOAuthIntegration(project);
    }
    throw Exception('Unsupported Jira integration');
  }

  /// Returns all the tasks that are linked to a jira project with OAuth
  Future<List<Task>> getProjectTasksFromJiraOAuthIntegration(
    Project project,
  ) {
    throw UnimplementedError();
  }

  /// Returns all the tasks that are linked to a jira project with Basic Auth
  Future<List<Task>> getProjectTasksFromJiraBasicAuthIntegration(
    Project project,
  ) async {
    final integration = project.integration as JiraBasicAuthIntegration;
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

    final results = await jira.issueSearch.searchForIssuesUsingJql(
      jql: 'project=${project.platformId}',
    );

    final tasks = results.issues.map((issue) {
      return Mappers.fromJiraApiIssueToTask(issue, project);
    }).toList();

    // Close the client to quickly terminate the process
    client.close();
    return tasks;
  }
}

final List<Integration> integrations = [
  JiraBasicAuthIntegration(
    username: 'yrodriguez@createthrive.com',
    password:
        'ATATT3xFfGF0vWVTGDI0FxAWu-K8WfKbNfFw8SMqG1lTrB_lUKRSzNYm-llYIgQRiFUD8XbZqxWxzn8bza1jZtXWdKqwbQsJzIjXAjBBD5lZaX9XNXxxiJfTWLf-fl4xSiMjGs8XyFvq65JIQTYSZeV83UDm6g4G7Trj7vkw_gooc6JEX5rvizA=F85A2173',
    url: 'zelfio.atlassian.net',
  ),
];
