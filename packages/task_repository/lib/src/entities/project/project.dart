// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:task_repository/src/entities/platform/platform.dart';

part 'project.g.dart';

/// {@template project}
/// A project that can be defined in a platform.
/// {@endtemplate}
@JsonSerializable()
class Project {
  /// Converts a [Map<String, dynamic>] into a [Project].
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// Converts a [Project] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  /// Creates a new [Project] instance with the provided properties.
  const Project({
    required this.id,
    required this.platformId,
    required this.platformURL,
    required this.platformName,
    required this.name,
    required this.description,
    required this.colorHex,
    this.platform,
    this.owner,
    this.iconUrl,
    this.slug,
  });

  /// Kick-off identifier for the project.
  final String id;

  /// Platform-specific identifier for the project.
  final String platformId;

  /// Platform-specific URL for the project (ex: Jira URL).
  final Uri platformURL;

  /// The integration way of the project.
  final Platform? platform;

  /// The name of the platform (ex: Jira).
  final String platformName;

  /// The name of the project.
  final String name;

  /// A brief description of the project.
  final String description;

  /// URL of the project icon, if available.
  final String? iconUrl;

  /// The color of the project.
  final String colorHex;

  /// The owner of the project.
  final String? owner;

  /// Slug of the project for indexed search.
  final String? slug;

  Project copyWith({
    String? id,
    String? platformId,
    Uri? platformURL,
    Platform? platform,
    String? platformName,
    String? name,
    String? description,
    String? iconUrl,
    String? colorHex,
    String? owner,
    String? slug,
  }) {
    return Project(
      id: id ?? this.id,
      platformId: platformId ?? this.platformId,
      platformURL: platformURL ?? this.platformURL,
      platform: platform ?? this.platform,
      platformName: platformName ?? this.platformName,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      colorHex: colorHex ?? this.colorHex,
      owner: owner ?? this.owner,
      slug: slug ?? this.slug,
    );
  }
}
