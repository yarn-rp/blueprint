// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:integrations_repository/integrations_repository.dart';

/// Refers to an event that is displayed in the calendar.
class CalendarEvent {
  CalendarEvent({
    required this.startTime,
    required this.endTime,
    required this.subject,
    this.isAllDay = false,
  });

  DateTime startTime;
  DateTime endTime;
  String subject;
  bool isAllDay;

  // copyWith
  CalendarEvent copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? subject,
    bool? isAllDay,
  }) {
    return CalendarEvent(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subject: subject ?? this.subject,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }
}

/// Refers to a task that is displayed in the calendar as a realization event.
class TaskCalendarEvent extends CalendarEvent {
  TaskCalendarEvent({
    required this.task,
    required super.startTime,
    Duration? estimatedTime,
  })  : assert(
          estimatedTime != null || task.estimatedTime != null,
          'Need an estimation for the task',
        ),
        super(
          subject: task.title,
          endTime: startTime.add(
            (estimatedTime ?? task.estimatedTime)!,
          ),
        );

  final Task task;

  @override
  TaskCalendarEvent copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? subject,
    bool? isAllDay,
  }) {
    return TaskCalendarEvent(
      task: task,
      startTime: startTime ?? this.startTime,
    );
  }
}
