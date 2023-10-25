part of 'blueprint_bloc.dart';

sealed class BlueprintEvent extends Equatable {
  const BlueprintEvent();
}

class BlueprintRequested extends BlueprintEvent {
  const BlueprintRequested();

  @override
  List<Object?> get props => [];
}

class EventsRequested extends BlueprintEvent {
  const EventsRequested();

  @override
  List<Object?> get props => [];
}

class BlueprintCreated extends BlueprintEvent {
  const BlueprintCreated({
    required this.items,
  });

  final List<CalendarEvent> items;

  @override
  List<Object?> get props => [items];
}
