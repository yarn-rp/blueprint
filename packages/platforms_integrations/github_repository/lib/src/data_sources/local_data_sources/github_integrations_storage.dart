import 'package:github_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template jira_integrations_storage}
/// A class to store jira integrations in a secure way, using encryption.
/// {@endtemplate}
class GitHubIntegrationsStorage
    extends PlatformIntegrationStorage<GitHubPlatform, GitHubIntegration> {
  /// {@macro jira_integrations_storage}
  GitHubIntegrationsStorage({
    required super.storage,
    required super.mapper,
    super.storageKey,
  });
}
