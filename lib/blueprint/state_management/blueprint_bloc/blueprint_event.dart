part of 'blueprint_bloc.dart';

sealed class BlueprintEvent extends Equatable {
  const BlueprintEvent();
}

class GetBlueprint extends BlueprintEvent {
  const GetBlueprint();

  @override
  List<Object?> get props => [];
}

class GetEvents extends BlueprintEvent {
  const GetEvents();

  @override
  List<Object?> get props => [];
}

class CreateBlueprint extends BlueprintEvent {
  const CreateBlueprint({
    required this.items,
  });

  final List<CalendarEvent> items;

  @override
  List<Object?> get props => [items];
}
