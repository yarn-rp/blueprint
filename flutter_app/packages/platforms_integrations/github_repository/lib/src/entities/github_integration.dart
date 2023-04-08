import 'package:github_repository/src/entities/github_platform.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// Github base class integration
abstract class GitHubIntegration extends Integration {
  /// Creates a new [GitHubIntegration] instance with the provided properties.
  const GitHubIntegration({
    required this.username,
  }) : super(githubPlatform);

  /// The username of the Github User
  final String username;

  @override
  List<Object?> get props => [username];
}
