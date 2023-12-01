/// A representation of a task in the database
typedef TaskModel = ({
  /// Kick off creation date
  DateTime createdAt,

  /// Kick off creation date
  DateTime updatedAt,

  /// Kick off id
  String id,

  /// Project to which the task belongs
  Project project,

  /// The url of the task in the platform
  Uri taskURL,

  /// Title of the task
  String title,

  /// maybe rich text (markdown || html)
  String description,

  /// start date of the task
  DateTime? startDate,

  /// due date of the task
  DateTime? dueDate,

  /// estimated time to complete the task
  Duration? estimatedTime,

  /// time logged in the task
  Duration? loggedTime,

  /// assigned users including me
  List<TaskUser> assigned,

  /// creator of the task
  TaskUser creator,

  /// is the task completed
  bool isCompleted,

  /// status of the task
  Iterable<TaskLabel> labels,

  /// The priority of the task
  /// This is an int between 1 and 5. 1 being the highest priority and 5 being
  /// the lowest priority.
  int priority,
});

/// A project the task belongs to
typedef Project = ({
  /// The project's name
  String name,

  /// The project's id
  String id,
});

/// A user on the task context
typedef TaskUser = ({
  /// The user's name
  String name,

  /// The user's email
  String email,
});

/// A label on the task context
typedef TaskLabel = ({
  /// The label's name
  String name,

  /// The label's color in hex
  String colorHex,
});
