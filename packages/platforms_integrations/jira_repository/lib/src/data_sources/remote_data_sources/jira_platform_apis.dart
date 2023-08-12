import 'dart:collection';

import 'package:atlassian_apis/jira_platform.dart' as jira;
import 'package:jira_repository/jira_repository.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template jira_integration_clients}
/// A class that holds jira clients for each jira integration.
/// {@endtemplate}
class JiraPlatformApis {
  /// {@macro jira_integration_clients}
  JiraPlatformApis({
    List<Integration> integrations = const <Integration>[],
  }) {
    _jiraPlatformApis = HashMap.fromIterable(
      integrations,
      value: (element) {
        if (element is JiraBasicAuthIntegration) {
          return jira.JiraPlatformApi(
            jira.ApiClient.basicAuthentication(
              Uri.https(element.url),
              user: element.username,
              apiToken: element.password,
            ),
          );
        }
        throw Exception('Unsupported jira integration');
      },
    );
  }
  late final HashMap<Integration, jira.JiraPlatformApi> _jiraPlatformApis;

  /// Returns the jira api for the given [integration].
  /// If the api does not exist, it will create a client and an api for it.
  /// Then, will add it to future use, and then return it.
  jira.JiraPlatformApi getFor(Integration integration) {
    if (_jiraPlatformApis.containsKey(integration)) {
      return _jiraPlatformApis[integration]!;
    }
    if (integration is JiraBasicAuthIntegration) {
      final client = jira.ApiClient.basicAuthentication(
        Uri.https(integration.url),
        user: integration.username,
        apiToken: integration.password,
      );
      final jiraClient = jira.JiraPlatformApi(client);
      _jiraPlatformApis[integration] = jiraClient;
      return jiraClient;
    }
    throw Exception('Unsupported jira integration');
  }
}
