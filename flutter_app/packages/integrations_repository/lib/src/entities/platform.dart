/// {@template platform}
/// A platform that contains the project.
/// {@endtemplate}
abstract class Platform {
  /// {@macro platform}
  const Platform({
    required this.id,
    required this.displayName,
    required this.iconUrl,
  });

  /// The kick-off id.
  final String id;

  /// The display name of the platform.
  final String displayName;

  /// The URL of the icon for the platform.

  final String iconUrl;
}

/// {@template jira_platform}
/// The Jira platform.
/// {@endtemplate}
class JiraPlatform extends Platform {
  /// {@macro platform}
  const JiraPlatform({
    required super.id,
  }) : super(
          displayName: 'Jira Atlassian',
          iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968875.png',
        );
}

/// {@template github_platform}
/// The Github platform.
/// {@endtemplate}
class GithubPlatform extends Platform {
  /// {@macro platform}
  const GithubPlatform({
    required super.id,
  }) : super(
          displayName: 'Github',
          iconUrl:
              'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
        );
}

/// {@template trello_platform}
/// The Trello platform.
/// {@endtemplate}
class TrelloPlatform extends Platform {
  /// {@macro platform}
  const TrelloPlatform({
    required super.id,
  }) : super(
          displayName: 'Trello',
          iconUrl:
              'https://cdn2.iconfinder.com/data/icons/social-icons-33/128/Trello-512.png',
        );
}

/// {@template asana_platform}
/// The Asana platform.
/// {@endtemplate}
class AsanaPlatform extends Platform {
  /// {@macro platform}
  const AsanaPlatform({
    required super.id,
  }) : super(
          displayName: 'Asana',
          iconUrl:
              'https://orstx.org/wp-content/uploads/2020/09/asana-icon.jpg',
        );
}

/// {@template asana_platform}
/// The Asana platform.
/// {@endtemplate}
class OpenAIPlatform extends Platform {
  /// {@macro platform}
  const OpenAIPlatform({
    required super.id,
  }) : super(
          displayName: 'OpenAI',
          iconUrl:
              'https://ih1.redbubble.net/image.4839005887.4100/st,small,507x507-pad,600x600,f8f8f8.jpg',
        );
}

const jira = JiraPlatform(id: 'jira');
const openAI = OpenAIPlatform(id: 'openai');
const github = GithubPlatform(id: 'github');
const trello = TrelloPlatform(id: 'trello');
const asana = AsanaPlatform(id: 'asana');
