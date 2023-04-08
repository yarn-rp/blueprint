import 'package:platform_integration_repository/platform_integration_repository.dart';

/// A platform for Jira (https://www.atlassian.com/software/jira).
class JiraPlatform extends Platform {
  /// Creates a new [JiraPlatform] instance with the provided properties.
  const JiraPlatform({
    required super.id,
    required super.iconUrl,
  }) : super(displayName: 'Jira');
}

const jiraPlatform = JiraPlatform(
  id: 'jira',
  iconUrl:
      'https://www.atlassian.com/dam/jcr:2b5c9a9a-3f1f-4d2b-af80-21f284a247e4/jira-logo.svg',
);
