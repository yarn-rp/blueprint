import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:platform_integration_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/src/key_pair_storage/key_pair_storage.dart';
import 'package:platform_integration_repository/src/mapper/platform_integration_mapper.dart';

/// {@template platform_integration_storage}
/// Base class to implement new integrations storage for a given [PlatformType].
/// This class is used by the PlatformIntegrationRepository to store and
/// retrieve integrations from a given platform.
/// To implement a new storage integration, you must extend this class and
/// implement the abstract methods.
/// {@endtemplate}
abstract class PlatformIntegrationStorage<PlatformType extends Platform,
    IntegrationType extends Integration> {
  /// Creates a new [PlatformIntegrationStorage] instance.
  PlatformIntegrationStorage({
    required KeyPairStorage storage,
    required PlatformIntegrationMapper<IntegrationType> mapper,
    required String storageKey,
  })  : _storage = storage,
        _storageKey = storageKey,
        _mapper = mapper,
        _streamController =
            StreamController<List<IntegrationType>>.broadcast() {
    refresh();
  }

  /// The key used to store the integrations in the device.
  final String _storageKey;

  /// The storage used to store the integrations in the device.
  /// This is a singleton, so it will be the same instance for all the
  /// implementations of this class.
  final KeyPairStorage _storage;

  /// The mapper used to convert the integrations to json and vice versa.
  final PlatformIntegrationMapper<IntegrationType> _mapper;

  /// The stream controller used to emit the integrations.
  final StreamController<List<IntegrationType>> _streamController;

  /// Returns a stream of all integrations, reacting to integration changes.
  Stream<List<IntegrationType>> get integrationsStream =>
      _streamController.stream;

  /// Stores the given [integrations] in the secure storage.
  Future<void> storeIntegrations(List<IntegrationType> integrations) async {
    try {
      log('Storing integrations: $integrations');

      final itemsStorables = integrations.map((integration) {
        final map = _mapper.toJson(integration);
        return json.encode(map);
      }).toList();

      await _storage.write(
        key: _storageKey,
        value: json.encode(itemsStorables),
      );

      final jsonString = await _storage.read(key: _storageKey);
      log('Stored integrations: $jsonString');

      refresh();
    } catch (e) {
      log('Storing integrations Error storing integrations: $e');
      rethrow;
    }
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
    log('Getting integrations');
    try {
      final jsonString = await _storage.read(key: _storageKey);
      await _storage.readAll().then((value) => log('All values: $value'));

      if (jsonString == null) {
        return [];
      }

      final integrationsDecoded = json.decode(jsonString);

      final integrations = (integrationsDecoded as List).map((e) {
        final json = jsonDecode(e as String);
        return _mapper.fromJson(json as Map<String, dynamic>);
      }).toList();
      log('Got integrations: $integrations');
      return integrations;
    } catch (e) {
      log('Error getting integrations: ', error: e);
      rethrow;
    }
  }
}
