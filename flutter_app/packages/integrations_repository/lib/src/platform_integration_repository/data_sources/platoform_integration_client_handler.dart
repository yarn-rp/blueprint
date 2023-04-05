
import 'dart:collection';

import 'package:integrations_repository/src/entities/entities.dart';

/// {@template integration_clients}
/// Base class to implement new integration clients for a given [PlatformType].
/// This class will have a hashmap of clients, one for each integration,
/// allowing to get the client for a given integration.
/// To implement a new integration client, you must extend this class and
///
abstract class PlatformIntegrationClientHandler<PlatformType extends Platform,
    IntegrationType extends Integration, ClientType> {
  /// {@macro github_integration_clients}
  PlatformIntegrationClientHandler({
    required List<IntegrationType> integrations,
  }) {
    _githubPlatformApis = HashMap.fromIterable(
      integrations,
      value: (integration) =>
          _createClientForIntegration(integration as IntegrationType),
    );
  }

  late final HashMap<IntegrationType, ClientType> _githubPlatformApis;

  /// Returns the github api for the given [integration].
  /// If the api does not exist, it will create a client and an api client for
  /// it. Then, will add it to future use, and then return it.
  ClientType getFor(IntegrationType integration) {
    if (_githubPlatformApis.containsKey(integration)) {
      return _githubPlatformApis[integration]!;
    }
    final client = _createClientForIntegration(integration);
    _githubPlatformApis[integration] = client;
    return client;
  }

  /// Creates a new client for the given [integration].
  ClientType _createClientForIntegration(IntegrationType integration);
}
