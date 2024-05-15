part of 'blueprint_bloc.dart';

sealed class BlueprintEvent extends Equatable {
  const BlueprintEvent();
}

class BlueprintRequested extends BlueprintEvent {
  const BlueprintRequested();

  @override
  List<Object?> get props => [];
}

class BlueprintTaskItemCreated extends BlueprintEvent {
  const BlueprintTaskItemCreated({
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

class PreviewItemsAccepted extends BlueprintEvent {
  const PreviewItemsAccepted();

  @override
  List<Object?> get props => [];
}

class PreviewsItemsRejected extends BlueprintEvent {
  const PreviewsItemsRejected();

  @override
  List<Object?> get props => [];
}

class BlueprintItemUpdated extends BlueprintEvent {
  const BlueprintItemUpdated({
    required this.item,
    required this.startTime,
    required this.endTime,
  });

  final BlueprintItem item;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object?> get props => [
        item,
        startTime,
        endTime,
      ];
}

class BlueprintItemDeleted extends BlueprintEvent {
  const BlueprintItemDeleted({
    required this.item,
  });

  final BlueprintItem item;

  @override
  List<Object?> get props => [
        item,
      ];
}
