import 'dart:async';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github/github.dart' as github_api;
import 'package:github_repository/src/data_sources/local_data_sources/github_integrations_storage.dart';
import 'package:github_repository/src/data_sources/remote_data_sources/github_platform_apis.dart';
import 'package:github_repository/src/entities/entities.dart';
import 'package:github_repository/src/mappers/mapper.dart';
import 'package:github_repository/src/ui/ui.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template github_repository}
/// Repository in charge of managing GitHub integrations.
/// {@endtemplate}
class GitHubRepository
    extends PlatformIntegrationRepository<GitHubPlatform, GitHubIntegration> {
  /// {@macro github_repository}
  GitHubRepository({
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
  Future<List<Task>> getProjectTasksRelatedToMe(Project project) async {
    final github = _apis.getFor(
      project.integration,
    );
    final repoSlug = github_api.RepositorySlug(
      project.owner ?? '',
      project.name,
    );
    late final List<github_api.Issue> issues;

    final githubUser = await github.users.getCurrentUser();

    try {
      issues = await github.issues
          .listByRepo(
        repoSlug,
      )
          .where((issue) {
        final user = issue.assignees;
        final isAssignedToMe = user != null && user.contains(githubUser);

        return isAssignedToMe;
      }).toList();
    } catch (e) {
      issues = [];
    }

    late final List<github_api.PullRequest> pullRequests;
    try {
      pullRequests = await github.pullRequests.list(repoSlug).where((element) {
        final reviewers = element.requestedReviewers;

        final isAssignedToMe = reviewers != null &&
            reviewers.any((user) => user.login == githubUser.login);
        final isAuthor = element.user?.login == githubUser.login;

        // Remove also the ones that are created by me but has't been reviewed
        // yet
        final hasNotBeenReviewedYet = element.state == 'open';
        return isAssignedToMe || (isAuthor && hasNotBeenReviewedYet);
      }).toList();
    } catch (e) {
      log(
        'Error getting pull requests from GitHub slug: ${project.owner}',
      );
      pullRequests = [];
    }

    final tasks = [
      ...issues.map(
        (event) => _integrationMapper.fromGitHubApiIssueToTask(
          event,
          project,
        ),
      ),
      ...pullRequests.map((event) {
        final isAssignedToMe = event.requestedReviewers != null &&
            event.requestedReviewers!.any(
              (user) => user.login == githubUser.login,
            );
        final isAuthor = event.user?.login == githubUser.login;

        return _integrationMapper.fromGitHubApiPullRequestToTask(
          event,
          project,
          isAssignedToMe: isAssignedToMe,
          isAuthor: isAuthor,
        );
      }),
    ];
    return tasks;
  }

  @override
  Future<List<Project>> getProjectsFromIntegration(
    GitHubIntegration integration,
  ) async {
    // Create the API wrapper from the http client
    final github = _apis.getFor(
      integration,
    );
    try {
      final repositories = await github.repositories
          .listRepositories(
        type: 'all',
        sort: 'updated',
        direction: 'desc',
      )
          .where((repo) {
        final isActive = !repo.disabled &&
            !repo.archived &&
            (repo.updatedAt?.isBefore(
                  DateTime.now().subtract(
                    const Duration(
                      days: 30,
                    ),
                  ),
                ) ??
                false);

        final hasIssues = repo.hasIssues;
        final hasPendingIssues = hasIssues && repo.openIssuesCount != 0;

        return isActive && hasPendingIssues;
      }).toList();

      final projects = repositories.map((event) {
        return _integrationMapper.fromGitHubApiRepositoryToProject(
          event,
          integration,
        );
      });

      return projects.toList();
    } catch (e) {
      return [];
    }
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
              integrationName: 'GitHub Basic Auth',
              description: 'GitHub integration using basic authentication',
            ),
            GitHubPlatformTokenIntegrationTile(
              platform: platform,
              onIntegrationCreated: onIntegrationCreated,
              integrationName: 'GitHub Token Auth',
              description: 'GitHub integration using token authentication',
            ),
          ];
}
