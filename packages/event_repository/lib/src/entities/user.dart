import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template project_user}
/// A representation of a user who is a member of a project.
/// This has an account in the platform that the project is defined in.
/// Don't confuse this user with the user of the app, since these are very
/// different.
/// {@endtemplate}
@JsonSerializable()
class User {
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// {@macro project_user}
  const User(
    this.platformUrl,
    this.displayName,
    this.avatarUrl,
    this.email,
  );

  /// The URL of the user's profile in the platform.
  final String? platformUrl;

  /// The display name of the user.
  final String? displayName;

  /// The URL of the user's avatar in the platform.
  final String? avatarUrl;

  /// The email of the user.
  final String? email;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
