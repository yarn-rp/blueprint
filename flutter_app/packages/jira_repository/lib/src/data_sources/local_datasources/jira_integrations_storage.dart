import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jira_repository/mappers/mapper.dart';
import 'package:jira_repository/src/entities/jira_integration.dart';

/// {@template jira_integrations_storage}
/// A class to store jira integrations in a secure way, using encryption.
/// {@endtemplate}
class JiraIntegrationsStorage {
  /// {@macro jira_integrations_storage}
  JiraIntegrationsStorage(this._storage) {
    refresh();
  }

  final FlutterSecureStorage _storage;

  final _streamController = StreamController<List<JiraIntegration>>.broadcast();

  /// Returns a stream of all integrations, reacting to integration changes.
  Stream<List<JiraIntegration>> get integrationsStream =>
      _streamController.stream;

  /// Stores the given [integrations] in the secure storage.
  Future<void> storeIntegrations(List<JiraIntegration> integrations) async {
    final itemsStorables =
        integrations.map(Mappers.fromIntegrationToJson).toList();

    await _storage.write(
      key: 'jira_integrations',
      value: itemsStorables.toString(),
    );

    refresh();
  }

  /// Refresh the stream of integrations, emitting the new list of current
  /// integrations.
  void refresh() => _getAllIntegrations().then(_streamController.add);

  /// Delete the given [integration] from the secure storage.
  Future<void> deleteIntegration(JiraIntegration integration) async {
    final integrations = await _getAllIntegrations();
    final newIntegrations =
        integrations.where((i) => i != integration).toList();

    await storeIntegrations(newIntegrations);
  }

  /// Returns the stored integrations.
  Future<List<JiraIntegration>> _getAllIntegrations() async {
    final jsonString = await _storage.read(key: 'jira_integrations');
    if (jsonString == null) {
      return [];
    }
    final integrationsDecoded = json.decode(jsonString);

    final integrations = (integrationsDecoded as List)
        .map((e) => Mappers.fromJsonToIntegration(e as Map<String, dynamic>))
        .toList();

    return integrations;
  }
}
