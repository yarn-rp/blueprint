import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:integrations_repository/src/entities/entities.dart';
import 'package:project_repository/project_repository.dart';

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
    required PlatformIntegrationStorage<PlatformType, IntegrationType> storage,
  }) : _storage = storage;

  final PlatformIntegrationStorage<PlatformType, IntegrationType> _storage;

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

/// {@template platform_integration_storage}
/// Base class to implement new integrations storage for a given [PlatformType].
/// This class is used by the [PlatformIntegrationRepository] to store and
/// retrieve integrations from a given platform.
/// To implement a new storage integration, you must extend this class and
/// implement the abstract methods.
/// {@endtemplate}
class PlatformIntegrationStorage<PlatformType extends Platform,
    IntegrationType extends Integration> {
  /// Creates a new [PlatformIntegrationStorage] instance.
  PlatformIntegrationStorage({
    required FlutterSecureStorage storage,
    required PlatformIntegrationMapper<IntegrationType> mapper,
    String? storageKey,
  })  : _storageKey = storageKey ?? PlatformType.runtimeType.toString(),
        _storage = storage,
        _mapper = mapper,
        _streamController = StreamController<List<IntegrationType>>.broadcast();

  /// The storage used to store the integrations in the device.
  /// This is a singleton, so it will be the same instance for all the
  /// implementations of this class.
  final FlutterSecureStorage _storage;

  /// The mapper used to convert the integrations to json and vice versa.
  final PlatformIntegrationMapper<IntegrationType> _mapper;

  /// The key used to store the integrations in the secure storage.
  final String _storageKey;

  /// The stream controller used to emit the integrations.
  final StreamController<List<IntegrationType>> _streamController;

  /// Returns a stream of all integrations, reacting to integration changes.
  Stream<List<IntegrationType>> get integrationsStream =>
      _streamController.stream;

  /// Stores the given [integrations] in the secure storage.
  Future<void> storeIntegrations(List<IntegrationType> integrations) async {
    final itemsStorables = integrations.map((integration) {
      final map = _mapper.toJson(integration);
      return json.encode(map);
    }).toList();

    await _storage.write(
      key: _storageKey,
      value: json.encode(itemsStorables),
    );

    refresh();
  }

  /// Refresh the stream of integrations, emitting the new list of current
  /// integrations.
  void refresh() => _getAllIntegrations().then(_streamController.add);

  /// Delete the given [integration] from the secure storage.
  Future<void> deleteIntegration(IntegrationType integration) async {
    final integrations = await _getAllIntegrations();
    final newIntegrations =
        integrations.where((i) => i != integration).toList();

    await storeIntegrations(newIntegrations);
  }

  /// Returns the stored integrations.
  Future<List<IntegrationType>> _getAllIntegrations() async {
    final jsonString = await _storage.read(key: _storageKey);
    if (jsonString == null) {
      return [];
    }
    final integrationsDecoded = json.decode(jsonString);

    final integrations = (integrationsDecoded as List).map((e) {
      final json = jsonDecode(e as String);
      return _mapper.fromJson(json as Map<String, dynamic>);
    }).toList();

    return integrations;
  }
}

/// {@template platform_integration_mapper}
/// Class in charge of mapping the [Integration] class to a json and viceversa.
/// To implement a new mapper, you must extend this class and implement the
/// abstract methods.
/// {@endtemplate}
abstract class PlatformIntegrationMapper<IntegrationType extends Integration> {
  /// Maps a [json] to an [IntegrationType].
  IntegrationType fromJson(Map<String, dynamic> json);

  /// Maps an [IntegrationType] to a Map<String,dynamic>.
  Map<String, dynamic> toJson(IntegrationType integration);
}

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
