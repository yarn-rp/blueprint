import 'package:api_client/src/models/event.dart';
import 'package:api_client/src/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore converter for the task model
final blueprintConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    final type = data['type'] as String;

    return switch (type) {
      'event' => BlueprintItem.event(
          (
            startTime: data['startTime'] as DateTime,
            endTime: data['endTime'] as DateTime,
            subject: data['subject'] as String,
            description: data['description'] as String,
            isAllDay: data['isAllDay'] as bool,
            colorHex: data['colorHex'] as String?,
            organizer: data['organizer'] != null
                ? (
                    name: data['organizer']?['name'] as String,
                    email: data['organizer']?['email'] as String,
                  )
                : null,
            attendees: data['attendees'] != null
                ? Map<String, AttendantStatus>.fromEntries(
                    (data['attendees'] as Map<String, dynamic>).entries.map(
                          (entry) => MapEntry(
                            entry.key,
                            AttendantStatus
                                .values[data['attendees'][entry.key] as int],
                          ),
                        ),
                  )
                : null,
            platformLink: data['platformLink'] as String?,
            calendar: (
              name: data['calendar']['name'] as String,
              id: data['calendar']['id'] as String,
              platformName: data['calendar']['platformName'] as String,
            ),
            conferenceData: data['conferenceData'] != null
                ? (
                    id: data['conferenceData']['id'] as String,
                    link: data['conferenceData']['link'] as String,
                    signature: data['conferenceData']['signature'] as String,
                    password: data['conferenceData']['password'] as String,
                  )
                : null,
            attendantStatus:
                AttendantStatus.values[data['attendantStatus'] as int],
          ),
        ),
      'task' => BlueprintItem.task(
          (
            createdAt: data['createdAt'] as DateTime,
            updatedAt: data['updatedAt'] as DateTime,
            id: snapshot.id,
            project: data['project'] as Project,
            taskURL: Uri.parse(data['taskURL'] as String),
            title: data['title'] as String,
            description: data['description'] as String,
            startDate: data['startDate'] as DateTime?,
            dueDate: data['dueDate'] as DateTime?,
            estimatedTime: data['estimatedTime'] as Duration?,
            loggedTime: data['loggedTime'] as Duration?,
            assigned: data['assigned'] as List<TaskUser>,
            creator: data['creator'] as TaskUser,
            isCompleted: data['isCompleted'] as bool,
            labels: data['labels'] as Iterable<TaskLabel>,
            priority: data['priority'] as int,
          ),
        ),
      _ => throw ArgumentError.value(type, 'type', 'Invalid type'),
    };
  },
  toFirestore: (
    BlueprintItem value,
    SetOptions? options,
  ) {
    return switch (value) {
      EventBlueprintItem() => const <String, dynamic>{},
      TaskBlueprintItem() => {
          'createdAt': value.data.createdAt,
          'updatedAt': value.data.updatedAt,
          'project': value.data.project,
          'taskURL': value.data.taskURL.toString(),
          'title': value.data.title,
          'description': value.data.description,
          'startDate': value.data.startDate,
          'dueDate': value.data.dueDate,
          'estimatedTime': value.data.estimatedTime,
          'loggedTime': value.data.loggedTime,
          'assigned': value.data.assigned,
          'creator': value.data.creator,
          'isCompleted': value.data.isCompleted,
          'labels': value.data.labels,
          'priority': value.data.priority,
        },
    };
  }
);

/// An item on the Blueprint collection
sealed class BlueprintItem {
  /// Creates a task blueprint item
  static BlueprintItem task(TaskModel data) => TaskBlueprintItem._(data);

  /// Creates an event blueprint item
  static BlueprintItem event(EventModel data) => EventBlueprintItem._(data);
}

/// A task on the Blueprint collection
final class TaskBlueprintItem extends BlueprintItem {
  TaskBlueprintItem._(this.data);

  /// The data of the task blueprint item
  final TaskModel data;
}

/// An event on the Blueprint collection
final class EventBlueprintItem extends BlueprintItem {
  EventBlueprintItem._(this.data);

  /// The data of the event blueprint item
  final EventModel data;
}
