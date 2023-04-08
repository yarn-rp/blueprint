import 'dart:collection';

import 'package:github/github.dart' as github_api;
import 'package:github_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template github_integration_clients}
/// A class that holds github clients for each github integration.
/// {@endtemplate}
class GitHubPlatformApis {
  /// {@macro github_integration_clients}
  GitHubPlatformApis({
    List<Integration> integrations = const <Integration>[],
  }) {
    _githubPlatformApis = HashMap.fromIterable(
      integrations,
      value: (element) {
        if (element is GitHubBasicAuthIntegration) {
          return github_api.GitHub(
            auth: github_api.Authentication.basic(
              element.username,
              element.password,
            ),
          );
        }
        throw Exception('Unsupported GitHub integration');
      },
    );
  }
  late final HashMap<Integration, github_api.GitHub> _githubPlatformApis;

  /// Returns the GitHub api for the given [integration].
  /// If the api does not exist, it will create a client and an api for it.
  /// Then, will add it to future use, and then return it.
  github_api.GitHub getFor(Integration integration) {
    if (_githubPlatformApis.containsKey(integration)) {
      return _githubPlatformApis[integration]!;
    }
    if (integration is GitHubBasicAuthIntegration) {
      final client = github_api.GitHub(
        auth: github_api.Authentication.basic(
          integration.username,
          integration.password,
        ),
      );

      _githubPlatformApis[integration] = client;
      return client;
    }
    throw Exception('Unsupported GitHub integration');
  }
}
