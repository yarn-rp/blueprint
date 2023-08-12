import 'package:jira_repository/src/entities/jira_integration.dart';
import 'package:jira_repository/src/entities/jira_platform.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template jira_integrations_storage}
/// A class to store jira integrations in a secure way, using encryption.
/// {@endtemplate}
class JiraIntegrationsStorage
    extends PlatformIntegrationStorage<JiraPlatform, JiraIntegration> {
  /// {@macro jira_integrations_storage}
  JiraIntegrationsStorage({
    required super.storage,
    required super.mapper,
    super.storageKey,
  });
}
