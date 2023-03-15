import 'package:poll_e_task/tickets/domain/entities/entities.dart';

/// {@template project}
/// A project that can be defined in a platform.
/// {@endtemplate}
class Project {
  /// Creates a new [Project] instance with the provided properties.
  const Project({
    required this.id,
    required this.platformId,
    required this.platformURL,
    required this.platform,
    required this.name,
    required this.description,
    required this.members,
    this.iconUrl,
  });

  /// Kick-off identifier for the project.
  final String id;

  /// Platform-specific identifier for the project.
  final String platformId;

  /// Platform-specific URL for the project (ex: Jira URL).
  final Uri platformURL;

  /// The platform of the project.
  final Platform platform;

  /// The name of the project.
  final String name;

  /// A brief description of the project.
  final String description;

  /// URL of the project icon, if available.
  final String? iconUrl;

  /// An array of users who are members of the project.
  final List<User> members;
}
