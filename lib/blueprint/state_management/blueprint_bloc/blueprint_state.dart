part of 'blueprint_bloc.dart';

enum BlueprintStatus { initial, loading, loaded, error }

class BlueprintState extends Equatable {
  BlueprintState({
    List<CalendarEvent>? items,
    this.status = BlueprintStatus.initial,
  }) {
    this.items = (items ?? [])..sortBy((event) => event.startTime);
  }

  final BlueprintStatus status;
  late final List<CalendarEvent> items;

  BlueprintState copyWith({
    List<CalendarEvent>? items,
    BlueprintStatus? status,
  }) {
    return BlueprintState(
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  /// Returns event that is happening right now
  CalendarEvent? get currentBlueprintEvent {
    final now = DateTime.now();
    final currentEvents = items.where((event) {
      return event.startTime.isBefore(now) && event.endTime.isAfter(now);
    }).toList();

    return currentEvents.firstOrNull;
  }

  Iterable<CalendarEvent> get upcomingBlueprintEvents {
    final now = DateTime.now();
    return items.where((event) => event.startTime.isAfter(now)).toList();
  }

  Iterable<CalendarEvent> get pastBlueprintEvents {
    final now = DateTime.now();
    return items.where((event) => event.endTime.isBefore(now)).toList();
  }

  @override
  List<Object?> get props => [items, status];
}
