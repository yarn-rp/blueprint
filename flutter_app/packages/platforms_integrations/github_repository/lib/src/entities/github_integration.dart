import 'package:github_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// Github base class integration
abstract class GitHubIntegration extends Integration {
  /// Creates a new [GitHubIntegration] instance with the provided properties.
  const GitHubIntegration() : super(githubPlatform);

  /// Creates a new [GitHubIntegration] instance from the provided JSON map.
  factory GitHubIntegration.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'basic_auth':
        return GitHubBasicAuthIntegration.fromJson(json);
      case 'token_auth':
        return GitHubTokenAuthIntegration.fromJson(json);
      default:
        throw UnimplementedError('Unknown GitHub integration type: $type');
    }
  }

  /// Converts this [GitHubIntegration] instance to a JSON map.
  Map<String, dynamic> toJson();
}
