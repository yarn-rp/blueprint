import 'dart:async';

import 'package:integrations_repository/src/exceptions/exceptions.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    Iterable<PlatformIntegrationService>? services,
  }) {
    _platformMap = Map.fromEntries(
      (services ?? []).map((e) => MapEntry(e.platform, e)),
    );
  }

  /// A map of all the platform services.
  /// This is used to get the repository from a specific platform.
  /// It is initialized in the constructor.
  late final Map<Platform, PlatformIntegrationService> _platformMap;

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration>> getAllIntegrations() =>
      _platformMap.values.map(_getRepositoryIntegrations).reduce(
            (previous, current) => previous.combineLatest(
              current,
              (a, b) => [...a, ...b],
            ),
          );

  /// Returns a stream of all integrations from all services.
  Stream<Iterable<Platform>> getAllPlatforms() => getAllIntegrations().map(
        (integrations) => integrations.map((e) => e.platform),
      );

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

  /// Returns a stream of all integrations from a specific [repository].
  ///
  /// Just a wrapper method to make the code more readable.
  Stream<List<Integration>> _getRepositoryIntegrations(
    PlatformIntegrationService repository,
  ) =>
      repository.getIntegrations();
}
