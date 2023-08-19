/// Represents the status of the ticket.
class Label {
  /// Create a new instance of [Label]
  Label(
    this.name,
    this.hexColor,
  );

  /// The text representation of the status. For example, "In Progress".
  final String name;

  /// The hex color of the status. For example, "#FF0000"
  final String hexColor;
}
