part of 'blueprint_bloc.dart';

enum BlueprintStatus { initial, loading, loaded, error }

class BlueprintState extends Equatable {
  const BlueprintState({
    this.items = const [],
    this.status = BlueprintStatus.initial,
  });

  final BlueprintStatus status;
  final List<CalendarEvent> items;

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
    return items.where((event) {
      return event.startTime.isAfter(now);
    }).toList();
  }

  @override
  List<Object?> get props => [items, status];
}
