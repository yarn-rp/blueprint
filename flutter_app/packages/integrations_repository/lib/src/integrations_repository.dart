import 'dart:async';
import 'dart:developer';

import 'package:integrations_repository/src/exceptions/exceptions.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    Iterable<PlatformIntegrationRepository>? repositories,
  }) {
    _platformMap = Map.fromEntries(
      (repositories ?? []).map((e) => MapEntry(e.platform, e)),
    );
  }

  /// A map of all the platform repositories.
  /// This is used to get the repository from a specific platform.
  /// It is initialized in the constructor.
  late final Map<Platform, PlatformIntegrationRepository> _platformMap;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration>> getAllIntegrations() =>
      _platformMap.values.map(_getRepositoryIntegrations).reduce(
            (previous, current) => previous.combineLatest(
              current,
              (a, b) => [...a, ...b],
            ),
          );

  /// Returns a stream of all integrations from all repositories.
  Stream<Iterable<Platform>> getAllPlatforms() => getAllIntegrations().map(
        (integrations) => integrations.map((e) => e.platform),
      );

  /// Returns a stream of all the projects that are linked to the app
  Stream<Iterable<Project>> getAllProjects() => _platformMap.values
      .map(
        (repo) => _getPlatformProjects(repo.platform),
      )
      .reduce(
        (previous, current) =>
            previous.combineLatest(current, (a, b) => [...a, ...b]),
      );

  /// Returns a stream of all tasks that are related to the current user in all
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

  /// Returns a list of tiles that can be used to create a new integration.
  Iterable<PlatformIntegrationTile> getIntegrationTiles(
    FutureOr<void> Function(Integration) onIntegrationCreated,
  ) =>
      _platformMap.values
          .map(
            (repository) => repository.getIntegrationTile(onIntegrationCreated),
          )
          .expand((e) => e);

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
  ) async* {
    final repository = _platformMap[platform];
    if (repository == null) {
      yield [];
      return;
    }
    try {
      log('Getting projects from $platform', name: 'IntegrationsRepository');

      /// Get all the integrations from the repository
      final integrationsStream = repository.getIntegrations();

      final integrationProjects = integrationsStream.asyncMap(
        (integrations) => Future.wait(
          integrations.map(_getProjectsFromIntegration),
        ),
      );

      yield* integrationProjects.map((platformProjects) {
        log(
          'Found ${platformProjects.map((e) => e.map((e) => e.name))} projects from $platform',
          name: 'IntegrationsRepository',
        );
        return platformProjects.expand((element) => element).toList();
      });
    } on IntegrationNotFoundException {
      log(
        'No integrations found for $platform',
        name: 'IntegrationsRepository',
      );
      yield [];
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
