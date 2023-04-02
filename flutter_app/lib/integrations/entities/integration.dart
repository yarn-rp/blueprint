import 'package:poll_e_task/tasks/entities/entities.dart';

abstract class Integration {
  Integration(this.platform);

  final Platform platform;
}

class JiraIntegration extends Integration {
  JiraIntegration({
    required this.url,
  }) : super(jira);

  /// The url of the Jira instance.
  final String url;
}

/// A Jira integration that uses basic authentication.
class JiraBasicAuthIntegration extends JiraIntegration {
  JiraBasicAuthIntegration({
    required this.username,
    required this.password,
    required super.url,
  });

  final String username;
  final String password;
}

/// A Jira integration that uses OAuth.
class JiraOAuthIntegration extends JiraIntegration {
  JiraOAuthIntegration({
    required this.consumerKey,
    required this.consumerSecret,
    required this.accessToken,
    required this.accessTokenSecret,
    required super.url,
  });

  final String consumerKey;
  final String consumerSecret;
  final String accessToken;
  final String accessTokenSecret;
}
