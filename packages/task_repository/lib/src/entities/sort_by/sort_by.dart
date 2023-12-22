/// Sort direction
enum SortDirection {
  asc,
  desc,
}

/// Sort fields for tasks.
enum SortField {
  dueDate('dueDate'),
  priority('priority'),
  startDate('startDate'),
  title('title'),
  updatedAt('updatedAt');

  const SortField(this.name);
  final String name;
  final SortDirection direction = SortDirection.desc;
}

/// A class that represents a sort order.
class SortBy {
  const SortBy(this.field, this.direction);
  final SortField field;
  final SortDirection direction;
}
