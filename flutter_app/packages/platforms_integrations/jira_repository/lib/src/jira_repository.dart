import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/mappers/mapper.dart';
import 'package:jira_repository/src/data_sources/local_datasources/jira_integrations_storage.dart';
import 'package:jira_repository/src/data_sources/remote_datasources/jira_platform_apis.dart';
import 'package:jira_repository/src/entities/entities.dart';
import 'package:project_repository/project_repository.dart';

final _defaultStorage = JiraIntegrationsStorage(const FlutterSecureStorage());
final _defaultApis = JiraPlatformApis();

/// {@template jira_repository}
/// Repository in charge of managing Jira integrations.
/// {@endtemplate}
class JiraRepository {
  /// {@macro jira_repository}
  JiraRepository({
    JiraIntegrationsStorage? storage,
    JiraPlatformApis? apis,
  }) {
    _storage = storage ?? _defaultStorage;
    _apis = apis ?? _defaultApis;
  }

  late final JiraIntegrationsStorage _storage;

  /// Clients used to interact with the Jira API.
  late final JiraPlatformApis _apis;

  /// Returns a stream of all projects, reacting to project changes.
  Stream<List<Integration>> getJiraIntegrations() =>
      _storage.integrationsStream;

  /// Adds a new [integration] to the repository.
  Future<void> addJiraIntegration(JiraIntegration integration) async =>
      _storage.storeIntegrations([integration]);

  /// Returns all the projects that are linked to a Jira integration.
  Future<List<Project>> getProjectsIntegration(
    JiraIntegration integration,
  ) async {
    if (integration is JiraBasicAuthIntegration) {
      return getProjectsFromJiraBasicAuthIntegration(integration);
    }
    throw Exception('Unsupported Jira integration');
  }

  /// Returns all the projects that are linked to a Jira with Basic Auth
  /// integration.
  @visibleForTesting
  Future<List<Project>> getProjectsFromJiraBasicAuthIntegration(
    JiraBasicAuthIntegration integration,
  ) async {
    // Create the API wrapper from the http client
    final jira = _apis.getFor(
      integration,
    );

    // Communicate with the APIs..
    final pageBeanProject = await jira.projects.searchProjects();

    final projects = pageBeanProject.values.map((jiraProject) {
      return Mappers.fromJiraApiProjectToProject(jiraProject, integration);
    }).toList();

    return projects;
  }

  /// Returns all the tasks that are linked to a jira project.
  Future<List<Task>> getProjectTasks(Project project) {
    if (project.integration is JiraBasicAuthIntegration) {
      return getProjectTasksFromJiraBasicAuthIntegration(project);
    }
    throw Exception('Unsupported Jira integration');
  }

  /// Returns all the tasks that are linked to a jira project with Basic Auth
  Future<List<Task>> getProjectTasksFromJiraBasicAuthIntegration(
    Project project,
  ) async {
    final integration = project.integration as JiraBasicAuthIntegration;

    final jira = _apis.getFor(
      integration,
    );
    final myUser = await jira.myself.getCurrentUser();

    // Communicate with the APIs..
    final results = await jira.issueSearch.searchForIssuesUsingJql(
      jql: 'project=${project.platformId} AND assignee=${myUser.accountId}',
      maxResults: 1000,
    );

    final tasks = results.issues.map((issue) {
      return Mappers.fromJiraApiIssueToTask(issue, project);
    }).toList();

    return tasks;
  }
}
