import 'package:platform_integration_repository/platform_integration_repository.dart';

/// A platform for Jira (https://www.atlassian.com/software/jira).
class GitHubPlatform extends Platform {
  /// Creates a new [GitHubPlatform] instance with the provided properties.
  const GitHubPlatform({
    required super.id,
    required super.iconUrl,
  }) : super(displayName: 'GitHub');
}

const githubPlatform = GitHubPlatform(
  id: 'github',
  iconUrl:
      'https://w7.pngwing.com/pngs/914/758/png-transparent-github-social-media-computer-icons-logo-android-github-logo-computer-wallpaper-banner-thumbnail.png',
);
