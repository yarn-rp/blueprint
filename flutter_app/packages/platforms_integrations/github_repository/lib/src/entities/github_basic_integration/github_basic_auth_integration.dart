import 'package:github_repository/src/entities/github_integration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_basic_auth_integration.g.dart';

/// A Github integration that uses basic authentication (username and password).
@JsonSerializable()
class GithubBasicAuthIntegration extends GithubIntegration {
  /// Creates a new [GithubBasicAuthIntegration] instance from a JSON object.
  factory GithubBasicAuthIntegration.fromJson(Map<String, dynamic> json) =>
      _$GithubBasicAuthIntegrationFromJson(json);

  /// Creates a new [GithubBasicAuthIntegration] instance with the provided
  const GithubBasicAuthIntegration({
    required this.username,
    required this.password,
  }) : super();

  /// The username of the Github user.
  final String username;

  /// The password of the Github user.
  final String password;
  @override
  List<Object?> get props => [username, password];

  /// Converts this [GithubBasicAuthIntegration] instance to a JSON object.
  /// Adds the type of the integration to the JSON object.
  Map<String, dynamic> toJson() =>
      _$GithubBasicAuthIntegrationToJson(this)..addAll({'type': 'basic_auth'});
}
