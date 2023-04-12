// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:jira_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// An integration with Jira (https://www.atlassian.com/software/jira).
/// software.
abstract class JiraIntegration extends Integration {
  /// Creates a new [JiraIntegration] instance with the provided properties.
  const JiraIntegration({
    required this.url,
    required this.user,
  }) : super(jiraPlatform);

  /// The url of the Jira instance.
  final String url;

  /// The user of the Jira instance.
  final String user;

  @override
  List<Object?> get props => [url, user];

  factory JiraIntegration.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'basic_auth':
        return JiraBasicAuthIntegration.fromJson(json);
      default:
        throw UnimplementedError('Unknown Jira integration type: $type');
    }
  }

  /// Converts this [JiraIntegration] instance to a JSON map.
  Map<String, dynamic> toJson();
}
