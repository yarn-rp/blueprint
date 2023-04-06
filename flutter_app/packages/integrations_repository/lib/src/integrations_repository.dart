import 'dart:collection/collection.dart';

import 'package:async/async.dart' show StreamGroup;
import 'package:integrations_repository/src/exceptions/exceptions.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    Iterable<PlatformIntegrationRepository>? repositories,
  }) {
    _platformMap = HashMap.fromEntries(
      (repositories ?? []).map((e) => MapEntry(e.platform, e)),
    );
  }

  /// A map of all the platform repositories.
  /// This is used to get the repository from a specific platform.
  /// It is initialized in the constructor.
  late final HashMap<Platform, PlatformIntegrationRepository> _platformMap;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration>> getIntegrations() => StreamGroup.merge(
        _platformMap.values.map(_getRepositoryIntegrations),
      );

  /// Returns a stream of all thhe projects that are linked to the app
  Stream<Iterable<Project>> getAllProjects() {
    final repositories = _platformMap.values;

    return StreamGroup.merge(
      repositories.map(
        (repo) => _getPlatformProjects(repo.platform),
      ),
    );
  }

  /// Returs a stream of all tasks that are related to the current user in all
  /// the projects that are linked to the app.
  Stream<Iterable<Task>> getAllTasksRelatedToMe() => getAllProjects()
      .asyncMap(
        (projects) => Future.wait(
          projects.map(_getProjectTasksRelatedToMe),
        ),
      )
      .map((tasks) => tasks.expand((e) => e));

  /// Adds a new [integration] to the repository.
  Future<void> addIntegration(Integration integration) {
    final repository = _platformMap[integration.platform];

    if (repository == null) {
      throw IntegrationUnsupportedException(integration);
    }
    return repository.createIntegration(integration);
  }

  /// Deletes an [integration] from the repository.
  Future<void> deleteIntegration(Integration integration) {
    final repository = _platformMap[integration.platform];

    if (repository == null) {
      throw IntegrationUnsupportedException(integration);
    }
    return repository.deleteIntegration(integration);
  }

  /// Returns all the tasks that are linked to an specific [project].
  Future<Iterable<Task>> _getProjectTasksRelatedToMe(Project project) {
    final integration = project.integration;
    final repository = _platformMap[integration.platform];

    if (repository == null) {
      throw IntegrationUnsupportedException(integration);
    }
    return repository.getProjectTasksRelatedToMe(project);
  }

  /// Returns all the projects that are under the give repository.
  /// If the integration is not found, because it does not belong to the
  /// repository, it returns an empty list.
  Stream<List<Project>> _getPlatformProjects(
    Platform platform,
  ) {
    final repository = _platformMap[platform];
    if (repository == null) {
      return Stream.value([]);
    }
    try {
      /// Get all the integrations from the repository
      final integrationsStream = repository.getIntegrations();

      final projectsStream = integrationsStream.asyncMap(
        (integrations) => Future.wait(
          integrations.map(_getProjectsFromIntegration),
        ).then((projects) => projects.expand((e) => e).toList()),
      );

      return projectsStream;
    } on IntegrationNotFoundException {
      return Stream.value([]);
    }
  }

  /// Returns a stream of all integrations from a specific [repository].
  ///
  /// Just a wrapper method to make the code more readable.
  Stream<List<Integration>> _getRepositoryIntegrations(
    PlatformIntegrationRepository repository,
  ) =>
      repository.getIntegrations();

  /// Returns all the projects that are linked to an specific [integration].
  Future<Iterable<Project>> _getProjectsFromIntegration(
    Integration integration,
  ) async {
    final repository = _platformMap[integration.platform];

    if (repository == null) {
      throw IntegrationUnsupportedException(integration);
    }
    return repository.getProjectsFromIntegration(integration);
  }
}
