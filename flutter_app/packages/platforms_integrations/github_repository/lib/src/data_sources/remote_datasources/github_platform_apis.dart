import 'dart:collection';

import 'package:github/github.dart';
import 'package:github_repository/src/entities/entities.dart';

/// {@template github_integration_clients}
/// A class that holds github clients for each github integration.
/// {@endtemplate}
class GithubPlatformApis {
  /// {@macro github_integration_clients}
  GithubPlatformApis({
    List<GithubIntegration> integrations = const <GithubIntegration>[],
  }) {
    _githubPlatformApis = HashMap.fromIterable(
      integrations,
      value: (integration) =>
          _createClientForIntegration(integration as GithubIntegration),
    );
  }

  late final HashMap<GithubIntegration, GitHub> _githubPlatformApis;

  /// Returns the github api for the given [integration].
  /// If the api does not exist, it will create a client and an api for it.
  /// Then, will add it to future use, and then return it.
  GitHub getFor(GithubIntegration integration) {
    if (_githubPlatformApis.containsKey(integration)) {
      return _githubPlatformApis[integration]!;
    }
    final client = _createClientForIntegration(integration);
    _githubPlatformApis[integration] = client;
    return client;
  }

  /// Creates a new client for the given [integration].
  /// Please, note that this function **does not add it to
  /// [_githubPlatformApis]**
  GitHub _createClientForIntegration(GithubIntegration integration) {
    GitHub? github;
    if (integration is GithubBasicAuthIntegration) {
      // Create a github client for with the given credentials.
      github = GitHub(
        auth: Authentication.basic(integration.username, integration.password),
      );
    }
    if (integration is GithubTokenAuthIntegration) {
      // Create a github client for with the given token.
      github = GitHub(auth: Authentication.withToken(integration.token));
    }

    if (github == null) {
      throw Exception('Unsupported Github integration');
    }

    return github;
  }
}
