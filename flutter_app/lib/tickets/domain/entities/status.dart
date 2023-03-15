/// Represents the status of the ticket.
class Status {
  Status(
    this.status,
    this.hexColor,
  );

  /// The text representation of the status. For example, "In Progress".
  final String status;

  /// The hex color of the status. For example, "#FF0000"
  final String hexColor;
}
