/// {@template platform}
/// A platform that contains the project.
/// {@endtemplate}
abstract class Platform {
  /// {@macro platform}
  const Platform({
    required this.id,
    required this.displayName,
    required this.iconUrl,
  });

  /// The kick-off id.
  final String id;

  /// The display name of the platform.
  final String displayName;

  /// The URL of the icon for the platform.

  final String iconUrl;
}
