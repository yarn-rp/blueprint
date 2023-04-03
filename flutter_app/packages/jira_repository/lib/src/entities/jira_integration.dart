import 'package:integrations_repository/integrations_repository.dart';

/// An integration with Jira (https://www.atlassian.com/software/jira).
/// software.
class JiraIntegration extends Integration {
  /// Creates a new [JiraIntegration] instance with the provided properties.
  const JiraIntegration({
    required this.url,
    required this.user,
  }) : super(jira);

  /// The url of the Jira instance.
  final String url;

  /// The user of the Jira instance.
  final String user;

  @override
  List<Object?> get props => [url, user];
}
