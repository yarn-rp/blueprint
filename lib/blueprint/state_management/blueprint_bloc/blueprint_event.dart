part of 'blueprint_bloc.dart';

sealed class BlueprintEvent extends Equatable {
  const BlueprintEvent();
}

class BlueprintRequested extends BlueprintEvent {
  const BlueprintRequested();

  @override
  List<Object?> get props => [];
}

class CalendarEventCreated extends BlueprintEvent {
  const CalendarEventCreated({
    required this.task,
    required this.startTime,
    required this.endTime,
  });

  final Task task;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object?> get props => [
        task,
        startTime,
        endTime,
      ];
}

class EventUpdated extends BlueprintEvent {
  const EventUpdated({
    required this.event,
    required this.startTime,
    required this.endTime,
  });

  final CalendarEvent event;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object?> get props => [
        event,
        startTime,
        endTime,
      ];
}

class EventDeleted extends BlueprintEvent {
  const EventDeleted({
    required this.event,
  });

  final CalendarEvent event;

  @override
  List<Object?> get props => [
        event,
      ];
}
