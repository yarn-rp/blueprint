import 'package:github_repository/src/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_token_auth_integration.g.dart';

/// A GitHub integration that uses basic authentication (username and password).
/// This one is not recommended, as it is not secure, and it will not work with
/// some services and platforms like Web due to CORS restrictions.
@JsonSerializable()
class GitHubTokenAuthIntegration extends GitHubIntegration {
  // from json
  factory GitHubTokenAuthIntegration.fromJson(Map<String, dynamic> json) =>
      _$GitHubTokenAuthIntegrationFromJson(json);

  /// Creates a new [GitHubTokenAuthIntegration] instance with the provided
  const GitHubTokenAuthIntegration({
    required this.token,
  }) : super();

  /// The password of the GitHub user.
  final String token;

  @override
  List<Object?> get props => [token];

  /// Converts this [GitHubTokenAuthIntegration] instance to a JSON object.
  /// Adds the type of the integration to the JSON object.
  Map<String, dynamic> toJson() => _$GitHubTokenAuthIntegrationToJson(this)
    ..addAll({'type': 'token_auth', 'platformId': platform.id});
}
