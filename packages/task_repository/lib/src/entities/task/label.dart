import 'package:json_annotation/json_annotation.dart';

part 'label.g.dart';

/// Represents the status of the ticket.
@JsonSerializable()
class Label {
  /// Create a new instance of [Label]
  Label(
    this.name,
    this.colorHex,
  );

  /// Converts a [Map<String, dynamic>] into a [Label].
  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

  /// Converts a [Label] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$LabelToJson(this);

  /// The text representation of the status. For example, "In Progress".
  final String name;

  /// The hex color of the status. For example, "#FF0000"
  final String colorHex;
}
