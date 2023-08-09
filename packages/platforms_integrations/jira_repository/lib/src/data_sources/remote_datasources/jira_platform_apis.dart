import 'dart:collection';

import 'package:atlassian_apis/jira_platform.dart' as Jira;
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
          return Jira.JiraPlatformApi(
            Jira.ApiClient.basicAuthentication(
              Uri.https(element.url),
              user: element.username,
              apiToken: element.password,
            ),
          );
        }
        throw Exception('Unsupported Jira integration');
      },
    );
  }
  late final HashMap<Integration, Jira.JiraPlatformApi> _jiraPlatformApis;

  /// Returns the jira api for the given [integration].
  /// If the api does not exist, it will create a client and an api for it.
  /// Then, will add it to future use, and then return it.
  Jira.JiraPlatformApi getFor(Integration integration) {
    if (_jiraPlatformApis.containsKey(integration)) {
      return _jiraPlatformApis[integration]!;
    }
    if (integration is JiraBasicAuthIntegration) {
      final client = Jira.ApiClient.basicAuthentication(
        Uri.https(integration.url),
        user: integration.username,
        apiToken: integration.password,
      );
      final jira = Jira.JiraPlatformApi(client);
      _jiraPlatformApis[integration] = jira;
      return jira;
    }
    throw Exception('Unsupported Jira integration');
  }
}
