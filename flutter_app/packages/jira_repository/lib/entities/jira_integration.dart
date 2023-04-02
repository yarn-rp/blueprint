import 'package:integrations_repository/integrations_repository.dart';

/// An integration with Jira (https://www.atlassian.com/software/jira).
/// software.
class JiraIntegration extends Integration {
  /// Creates a new [JiraIntegration] instance with the provided properties.
  JiraIntegration({
    required this.url,
  }) : super(jira);

  /// The url of the Jira instance.
  final String url;
}

/// A Jira integration that uses basic authentication (username and password).
/// This one is not recommended, as it is not secure, and it will not work with
/// some services and platforms like Web due to CORS restrictions.
class JiraBasicAuthIntegration extends JiraIntegration {
  /// Creates a new [JiraBasicAuthIntegration] instance with the provided
  JiraBasicAuthIntegration({
    required this.username,
    required this.password,
    required super.url,
  });

  /// The username of the Jira user.
  final String username;

  /// The password of the Jira user.
  final String password;
}

/// A Jira integration that uses OAuth. This is the recommended way to integrate
/// with Jira.
class JiraOAuthIntegration extends JiraIntegration {
  /// Creates a new [JiraOAuthIntegration] instance with the provided
  /// properties.
  JiraOAuthIntegration({
    required this.consumerKey,
    required this.consumerSecret,
    required this.accessToken,
    required this.accessTokenSecret,
    required super.url,
  });

  /// The consumer key of the Jira OAuth application.
  final String consumerKey;

  /// The consumer secret of the Jira OAuth application
  final String consumerSecret;

  /// The access token of the Jira OAuth application.
  final String accessToken;

  /// The access token secret of the Jira OAuth application.
  final String accessTokenSecret;
}
