import 'package:platform_integration_repository/platform_integration_repository.dart';

/// A platform for Jira (https://www.atlassian.com/software/jira).
class JiraPlatform extends Platform {
  /// Creates a new [JiraPlatform] instance with the provided properties.
  const JiraPlatform({
    required super.id,
    required super.iconUrl,
  }) : super(displayName: 'Jira');
}

/// The Jira platform.
const jiraPlatform = JiraPlatform(
  id: 'jira',
  iconUrl:
      'https://logos-world.net/wp-content/uploads/2021/02/Jira-Emblem-700x394.png',
);
