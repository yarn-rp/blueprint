import 'package:github_repository/src/entities/github_integration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_token_auth_integration.g.dart';

/// A Github integration that uses token authentication.
@JsonSerializable()
class GithubTokenAuthIntegration extends GithubIntegration {
  /// Creates a new [GithubTokenAuthIntegration] instance with the provided
  const GithubTokenAuthIntegration({
    required this.token,
  }) : super();

  /// Creates a new [GithubTokenAuthIntegration] instance from a JSON object.
  factory GithubTokenAuthIntegration.fromJson(Map<String, dynamic> json) =>
      _$GithubTokenAuthIntegrationFromJson(json);

  /// The token of the Github user.
  final String token;

  /// Converts this [GithubTokenAuthIntegration] instance to a JSON object.
  /// Adds the type of the integration to the JSON object.
  Map<String, dynamic> toJson() =>
      _$GithubTokenAuthIntegrationToJson(this)..addAll({'type': 'token_auth'});

  @override
  List<Object?> get props => [token];
}
