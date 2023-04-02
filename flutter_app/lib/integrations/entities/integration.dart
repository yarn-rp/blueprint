import 'package:poll_e_task/tasks/entities/entities.dart';

abstract class Integration {
  Integration(this.platform);

  final Platform platform;
}

class JiraBasicAuthIntegration extends Integration {
  JiraBasicAuthIntegration({
    required this.username,
    required this.password,
    required this.url,
  }) : super(jira);

  final String username;
  final String password;
  final String url;
}
