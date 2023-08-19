import 'dart:async';

import 'package:local_integrations_repository/src/exceptions/exceptions.dart';
import 'package:local_platform_integration_repository/local_platform_integration_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// {@template integrations_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class IntegrationsRepository<
    PlatformType extends Platform,
    PlatformIntegrationType extends PlatformIntegrationService<PlatformType,
        Integration<PlatformType>>> {
  /// {@macro integrations_repository}
  IntegrationsRepository({
    Iterable<PlatformIntegrationType>? services,
  }) {
    _platformMap = Map.fromEntries(
      (services ?? []).map((e) => MapEntry(e.platform, e)),
    );
  }

  /// A map of all the platform services.
  /// This is used to get the service from a specific platform.
  /// It is initialized in the constructor.
  late final Map<PlatformType, PlatformIntegrationType> _platformMap;

  /// Returns a stream of all services.
  Stream<Iterable<PlatformIntegrationType>> get services =>
      Stream.value(_platformMap.values);

  /// Returns a stream of all integrations from all sources. This stream reacts
  /// to changes in the integrations, like additions or removals.
  Stream<Iterable<Integration<PlatformType>>> getAllIntegrations() =>
      _platformMap.values.map(_getRepositoryIntegrations).reduce(
            (previous, current) => previous.combineLatest(
              current,
              (a, b) => [...a, ...b],
            ),
          );

  /// Returns a stream of all integrations from all services.
  Stream<Iterable<PlatformType>> getAllPlatforms() => getAllIntegrations().map(
        (integrations) => integrations.map((e) => e.platform),
      );

  /// Adds a new [integration] to the service.
  Future<void> addIntegration(Integration<PlatformType> integration) {
    final service = _platformMap[integration.platform];

    if (service == null) {
      throw IntegrationUnsupportedException(integration);
    }
    return service.createIntegration(integration);
  }

  /// Deletes an [integration] from the service.
  Future<void> deleteIntegration(Integration<PlatformType> integration) {
    final service = _platformMap[integration.platform];

    if (service == null) {
      throw IntegrationUnsupportedException(integration);
    }
    return service.deleteIntegration(integration);
  }

  /// Returns a stream of all integrations from a specific [service].
  ///
  /// Just a wrapper method to make the code more readable.
  Stream<List<Integration<PlatformType>>> _getRepositoryIntegrations(
    PlatformIntegrationType service,
  ) =>
      service.getIntegrations();
}
