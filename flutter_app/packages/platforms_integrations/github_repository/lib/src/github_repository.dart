import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github/github.dart' as github_api;
import 'package:github_repository/src/data_sources/local_datasources/github_integrations_storage.dart';
import 'package:github_repository/src/data_sources/remote_datasources/github_platform_apis.dart';
import 'package:github_repository/src/entities/entities.dart';
import 'package:github_repository/src/mappers/mapper.dart';
import 'package:github_repository/src/ui/github_platform_basic_integration_tile.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template github_repository}
/// Repository in charge of managing GitHub integrations.
/// {@endtemplate}
class GithubRepository
    extends PlatformIntegrationRepository<GitHubPlatform, GitHubIntegration> {
  /// {@macro github_repository}
  GithubRepository({
    required FlutterSecureStorage secureStorage,
    String? storageKey,
    GitHubPlatform? platform,
    GitHubPlatformApis? apis,
    GitHubIntegrationMapper mapper = const GitHubIntegrationMapper(),
  })  : _apis = apis ?? GitHubPlatformApis(),
        _integrationMapper = mapper,
        super(
          platform: platform ?? githubPlatform,
          storage: GitHubIntegrationsStorage(
            storageKey: storageKey ?? 'github_integrations',
            storage: secureStorage,
            mapper: mapper,
          ),
        );

  final GitHubIntegrationMapper _integrationMapper;
  final GitHubPlatformApis _apis;

  @override
  Future<List<Task>> getProjectTasksRelatedToMe(Project project) {
    if (project.integration is GitHubBasicAuthIntegration) {
      return getProjectTasksFromGitHubBasicAuthIntegration(project);
    }
    throw Exception('Unsupported GitHub integration');
  }

  @override
  Future<List<Project>> getProjectsFromIntegration(
    GitHubIntegration integration,
  ) {
    if (integration is GitHubBasicAuthIntegration) {
      return getProjectsFromGitHubBasicAuthIntegration(integration);
    }
    throw Exception('Unsupported GitHub integration');
  }

  /// Returns all the projects that are linked to a GitHub with Basic Auth
  /// integration.
  @visibleForTesting
  Future<List<Project>> getProjectsFromGitHubBasicAuthIntegration(
    GitHubBasicAuthIntegration integration,
  ) async {
    // Create the API wrapper from the http client
    final github = _apis.getFor(
      integration,
    );

    final repositories = await github.repositories
        .listRepositories(
          type: 'all',
        )
        .toList();

    final projects = repositories.map((event) {
      return _integrationMapper.fromGitHubApiRepositoryToProject(
        event,
        integration,
      );
    });

    return projects.toList();
  }

  /// Returns all the tasks that are linked to a github project with Basic Auth
  @visibleForTesting
  Future<List<Task>> getProjectTasksFromGitHubBasicAuthIntegration(
    Project project,
  ) async {
    final integration = project.integration as GitHubBasicAuthIntegration;

    final github = _apis.getFor(
      integration,
    );
    final repoSlug = github_api.RepositorySlug(
      project.owner ?? '',
      project.name,
    );

    final issues = await github.issues
        .listByRepo(
          repoSlug,
        )
        .toList();

    final pullRequests = await github.pullRequests.list(repoSlug).toList();

    final tasks = [
      ...issues.map(
        (event) => _integrationMapper.fromGitHubApiIssueToTask(
          event,
          project,
        ),
      ),
    ];
    return tasks;
  }

  @override
  Iterable<PlatformIntegrationTile<GitHubPlatform, GitHubIntegration>>
      getIntegrationTile(
    FutureOr<void> Function(GitHubIntegration) onIntegrationCreated,
  ) =>
          [
            GitHubPlatformBasicIntegrationTile(
              platform: platform,
              onIntegrationCreated: onIntegrationCreated,
              integrationName: 'GitHub',
              description: 'GitHub integration using basic authentication',
            )
          ];
}
