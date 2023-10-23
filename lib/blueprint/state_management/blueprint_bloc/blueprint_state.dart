part of 'blueprint_bloc.dart';

sealed class BlueprintState extends Equatable {
  const BlueprintState();
}

class BlueprintInitial extends BlueprintState {
  const BlueprintInitial();

  @override
  List<Object?> get props => [];
}

class BlueprintScheduled extends BlueprintState {
  const BlueprintScheduled({
    required this.items,
    required this.events,
  });

  final List<CalendarEvent> items;
  final List<GeneralCalendarEvent> events;

  @override
  List<Object?> get props => [items, events];
}

class BlueprintNotScheduled extends BlueprintState {
  const BlueprintNotScheduled({
    required this.events,
  });

  final List<GeneralCalendarEvent> events;

  @override
  List<Object?> get props => [
        events,
      ];
}

class BlueprintError extends BlueprintState {
  const BlueprintError({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => [error];
}
