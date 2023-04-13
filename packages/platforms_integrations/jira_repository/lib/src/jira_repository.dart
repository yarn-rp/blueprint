import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jira_repository/jira_repository.dart';
import 'package:jira_repository/src/data_sources/local_datasources/jira_integrations_storage.dart';
import 'package:jira_repository/src/data_sources/remote_datasources/jira_platform_apis.dart';
import 'package:jira_repository/src/entities/jira_platform.dart';
import 'package:jira_repository/src/mappers/mapper.dart';
import 'package:jira_repository/src/ui/jira_platform_basic_integration_tile.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template jira_repository}
/// Repository in charge of managing Jira integrations.
/// {@endtemplate}
class JiraRepository
    extends PlatformIntegrationRepository<JiraPlatform, JiraIntegration> {
  /// {@macro jira_repository}
  JiraRepository({
    required FlutterSecureStorage secureStorage,
    String? storageKey,
    JiraPlatform? platform,
    JiraPlatformApis? apis,
    JiraIntegrationMapper mapper = const JiraIntegrationMapper(),
  })  : _apis = apis ?? JiraPlatformApis(),
        _integrationMapper = mapper,
        super(
          platform: platform ?? jiraPlatform,
          storage: JiraIntegrationsStorage(
            storageKey: storageKey ?? 'jira_integrations',
            storage: secureStorage,
            mapper: mapper,
          ),
        );
  final JiraIntegrationMapper _integrationMapper;
  final JiraPlatformApis _apis;

  @override
  Future<List<Task>> getProjectTasksRelatedToMe(Project project) {
    if (project.integration is JiraBasicAuthIntegration) {
      return getProjectTasksFromJiraBasicAuthIntegration(project);
    }
    throw Exception('Unsupported Jira integration');
  }

  @override
  Future<List<Project>> getProjectsFromIntegration(
    JiraIntegration integration,
  ) {
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
      return _integrationMapper.fromJiraApiProjectToProject(
        jiraProject,
        integration,
      );
    }).toList();

    return projects;
  }

  /// Returns all the tasks that are linked to a jira project with Basic Auth
  @visibleForTesting
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
      return _integrationMapper.fromJiraApiIssueToTask(issue, project);
    }).toList();

    return tasks;
  }

  @override
  Iterable<PlatformIntegrationTile<JiraPlatform, JiraIntegration>>
      getIntegrationTile(
    FutureOr<void> Function(JiraIntegration) onIntegrationCreated,
  ) =>
          [
            JiraPlatformBasicIntegrationTile(
              platform: platform,
              onIntegrationCreated: onIntegrationCreated,
              integrationName: 'Jira',
              description: 'Jira integration using basic authentication',
            )
          ];
}
