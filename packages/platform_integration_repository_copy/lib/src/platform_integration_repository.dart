import 'dart:async';

import 'package:platform_integration_repository/src/data_sources/platform_integration_storage.dart';
import 'package:platform_integration_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/src/ui/ui.dart';

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
abstract class PlatformIntegrationService<PlatformType extends Platform,
    IntegrationType extends Integration> {
  /// Creates a new [PlatformIntegrationService] instance.
  PlatformIntegrationService({
    required this.platform,
    required PlatformIntegrationStorage<PlatformType, IntegrationType> storage,
  }) : _storage = storage;

  final PlatformIntegrationStorage<PlatformType, IntegrationType> _storage;

  /// The platform that represents the repository
  final PlatformType platform;

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

  /// Returns a list of PlatformIntegrationTile that will be used to display
  /// all the possible integrations in the ui and how to integrate them.
  Iterable<PlatformIntegrationTile<PlatformType, IntegrationType>>
      getIntegrationTile(
    FutureOr<void> Function(IntegrationType) onIntegrationCreated,
  );
}
