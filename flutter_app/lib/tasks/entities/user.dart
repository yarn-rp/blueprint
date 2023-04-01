/// {@template project_user}
/// A representation of a user who is a member of a project.
/// This has an account in the platform that the project is defined in.
/// Don't confuse this user with the user of the app, since these are very
/// different.
/// {@endtemplate}
class User {
  const User(
    this.platformUrl,
    this.displayName,
    this.avatarUrl,
  );

  /// The URL of the user's profile in the platform.
  final String platformUrl;

  /// The display name of the user.
  final String displayName;

  /// The URL of the user's avatar in the platform.
  final String avatarUrl;
}
