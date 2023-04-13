import 'package:jira_repository/src/entities/jira_integration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jira_basic_auth_integration.g.dart';

/// A Jira integration that uses basic authentication (username and password).
/// This one is not recommended, as it is not secure, and it will not work with
/// some services and platforms like Web due to CORS restrictions.
@JsonSerializable()
class JiraBasicAuthIntegration extends JiraIntegration {
  /// Creates a new [JiraBasicAuthIntegration] instance from a JSON object.
  factory JiraBasicAuthIntegration.fromJson(Map<String, dynamic> json) =>
      _$JiraBasicAuthIntegrationFromJson(json);

  /// Creates a new [JiraBasicAuthIntegration] instance with the provided
  const JiraBasicAuthIntegration({
    required this.username,
    required this.password,
    required super.url,
  }) : super(user: username);

  /// The username of the Jira user.
  final String username;

  /// The password of the Jira user.
  final String password;
  @override
  List<Object?> get props => [url, user, username, password];

  /// Converts this [JiraBasicAuthIntegration] instance to a JSON object.
  /// Adds the type of the integration to the JSON object.
  Map<String, dynamic> toJson() => _$JiraBasicAuthIntegrationToJson(this)
    ..addAll({'type': 'basic_auth', 'platformId': platform.id});
}
