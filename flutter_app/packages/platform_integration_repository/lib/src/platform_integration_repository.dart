import 'dart:async';
import 'package:platform_integration_repository/src/data_sources/platform_integration_storage.dart';
import 'package:platform_integration_repository/src/entities/entities.dart';

/// {@template platform_integration_repository}
/// Base class to implement new integrations for a given [PlatformType].
/// To implement a new repository integration, you must extend this class and
/// implement the abstract methods.
///
/// [IntegrationType] represents the base class for all integrations supported
/// by the repository. For example, if you are implementing a repository for
/// basic authentication and token authentication, you must create three
/// classes:
/// ```dart
/// class SomeBaseClass extends Integration {
///   ...
/// }
/// class SomeBasicAuthClass extends SomeBaseClass {
///   ...
/// }
/// class SomeTokenAuthClass extends SomeBaseClass {
///  ...
/// }
/// ```
/// {@endtemplate}
abstract class PlatformIntegrationRepository<PlatformType extends Platform,
    IntegrationType extends Integration> {
  /// Creates a new [PlatformIntegrationRepository] instance.
  PlatformIntegrationRepository({
    required this.platform,
    required PlatformIntegrationStorage<PlatformType, IntegrationType> storage,
  }) : _storage = storage;

  final PlatformIntegrationStorage<PlatformType, IntegrationType> _storage;

  /// The platform that reporesents the repository
  final PlatformType platform;

  /// Returns all the tasks that are linked to an specific [project] and are
  /// related to the current user. There are multiple reasons why a task can be
  /// related to the current user, depending on the platform. In task management
  /// platforms, this can be because the user is the assignee of the task.
  /// In project management platforms, this can be because the user is a member
  Future<List<Task>> getProjectTasksRelatedToMe(Project project);

  /// Returns all the projects that are linked to an specific [integration].
  ///
  /// This will communicate with the specific platform apis to get the projects
  /// linked to given integration.
  Future<List<Project>> getProjectsFromIntegration(IntegrationType integration);

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<List<IntegrationType>> getIntegrations() =>
      _storage.integrationsStream;

  /// Creates a new [integration] in the repository.
  Future<void> createIntegration(IntegrationType integration) =>
      _storage.storeIntegrations([integration]);

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(IntegrationType integration) =>
      _storage.deleteIntegration(integration);
}
