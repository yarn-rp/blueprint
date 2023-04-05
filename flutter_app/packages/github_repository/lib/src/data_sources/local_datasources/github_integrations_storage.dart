import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_repository/mappers/mapper.dart';
import 'package:github_repository/src/entities/github_integration.dart';

/// {@template github_integrations_storage}
/// A class to store github integrations in a secure way, using encryption.
/// {@endtemplate}
class GithubIntegrationsStorage {
  /// {@macro github_integrations_storage}
  GithubIntegrationsStorage(this._storage) {
    refresh();
  }

  final FlutterSecureStorage _storage;

  final _streamController =
      StreamController<List<GithubIntegration>>.broadcast();

  /// Returns a stream of all integrations, reacting to integration changes.
  Stream<List<GithubIntegration>> get integrationsStream =>
      _streamController.stream;

  /// Stores the given [integrations] in the secure storage.
  Future<void> storeIntegrations(List<GithubIntegration> integrations) async {
    final itemsStorables = integrations.map((integration) {
      final map = Mappers.fromIntegrationToJson(integration);
      return json.encode(map);
    }).toList();

    await _storage.write(
      key: 'github_integrations',
      value: json.encode(itemsStorables),
    );

    refresh();
  }

  /// Refresh the stream of integrations, emitting the new list of current
  /// integrations.
  void refresh() => _getAllIntegrations().then(_streamController.add);

  /// Delete the given [integration] from the secure storage.
  Future<void> deleteIntegration(GithubIntegration integration) async {
    final integrations = await _getAllIntegrations();
    final newIntegrations =
        integrations.where((i) => i != integration).toList();

    await storeIntegrations(newIntegrations);
  }

  /// Returns the stored integrations.
  Future<List<GithubIntegration>> _getAllIntegrations() async {
    // await _storage.deleteAll();
    final jsonString = await _storage.read(key: 'github_integrations');
    if (jsonString == null) {
      return [];
    }
    final integrationsDecoded = json.decode(jsonString);

    final integrations = (integrationsDecoded as List).map((e) {
      final json = jsonDecode(e as String);
      return Mappers.fromJsonToIntegration(json as Map<String, dynamic>);
    }).toList();

    return integrations;
  }
}
