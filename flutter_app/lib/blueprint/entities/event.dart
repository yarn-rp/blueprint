import 'package:integrations_repository/integrations_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// Refers to an event that is displayed in the calendar.
class CalendarEvent extends Appointment {
  CalendarEvent({
    required super.subject,
    required super.startTime,
    required super.endTime,
  }) : super();

  @override
  bool get isAllDay => startTime.isAtSameMomentAs(endTime);
}

/// Refers to a task that is displayed in the calendar as a realization event.
class TaskCalendarEvent extends CalendarEvent {
  TaskCalendarEvent(
    this.task, {
    required super.subject,
    required super.startTime,
    required super.endTime,
  });

  final Task task;
}
