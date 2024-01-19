import 'package:integrations_repository/src/entities/platform/platform.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authenticator.g.dart';

@JsonSerializable()
class AuthenticatorUserData {
  AuthenticatorUserData({
    this.name,
    this.email,
    this.gid,
  });

  factory AuthenticatorUserData.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatorUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatorUserDataToJson(this);

  final String? name;
  final String? email;
  final String? gid;
}

@JsonSerializable()
class Authenticator {
  Authenticator({
    required this.id,
    required this.platform,
    required this.userData,
  });

  factory Authenticator.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatorToJson(this);

  final String id;
  final Platform platform;
  final AuthenticatorUserData userData;
}
