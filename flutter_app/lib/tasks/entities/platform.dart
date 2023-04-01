/// {@template platform}
/// A platform that contains the project.
/// {@endtemplate}
abstract class Platform {
  /// {@macro platform}
  Platform({
    required this.id,
    required this.displayName,
    this.howToIntegrateGuide,
    required this.iconUrl,
  });

  /// The kick-off id.
  final String id;

  /// The display name of the platform.
  final String displayName;

  /// The explanation of how to integrate the platform to kick off.
  final HowToIntegrateGuide? howToIntegrateGuide;

  /// The URL of the icon for the platform.

  final String iconUrl;
}

/// {@template jira_platform}
/// The Jira platform.
/// {@endtemplate}
class JiraPlatform extends Platform {
  /// {@macro platform}
  JiraPlatform({
    required super.id,
    super.howToIntegrateGuide,
  }) : super(
          displayName: 'Jira',
          iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968875.png',
        );
}

/// {@template github_platform}
/// The Github platform.
/// {@endtemplate}
class GithubPlatform extends Platform {
  /// {@macro platform}
  GithubPlatform({
    required super.id,
    super.howToIntegrateGuide,
  }) : super(
          displayName: 'Github',
          iconUrl:
              'https://1000logos.net/wp-content/uploads/2021/05/GitHub-logo.png',
        );
}

/// {@template trello_platform}
/// The Trello platform.
/// {@endtemplate}
class TrelloPlatform extends Platform {
  /// {@macro platform}
  TrelloPlatform({
    required super.id,
    super.howToIntegrateGuide,
  }) : super(
          displayName: 'Trello',
          iconUrl:
              'https://1000logos.net/wp-content/uploads/2021/05/Trello-logo.png',
        );
}

/// {@template asana_platform}
/// The Asana platform.
/// {@endtemplate}
class AsanaPlatform extends Platform {
  /// {@macro platform}
  AsanaPlatform({
    required super.id,
    super.howToIntegrateGuide,
  }) : super(
          displayName: 'Asana',
          iconUrl:
              'https://1000logos.net/wp-content/uploads/2021/05/Asana-logo.png',
        );
}

/// An explanation of how to integrate the platform to kick off (rich-text).
/// This documentation can include information on how to install or use a
/// specific platform related aspects of the integration.
abstract class HowToIntegrateGuide {}
