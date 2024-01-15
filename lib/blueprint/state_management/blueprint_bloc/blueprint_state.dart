part of 'blueprint_bloc.dart';

enum BlueprintStatus { initial, loading, loaded, error }

class BlueprintState extends Equatable {
  BlueprintState({
    List<CalendarEvent>? items,
    DateTime? updatedAt,
    this.status = BlueprintStatus.initial,
  }) {
    this.updatedAt = updatedAt ?? DateTime.now();
    this.items = (items ?? [])..sortBy((event) => event.startTime);
  }

  final BlueprintStatus status;
  late final List<CalendarEvent> items;
  late final DateTime updatedAt;

  BlueprintState copyWith({
    List<CalendarEvent>? items,
    BlueprintStatus? status,
    DateTime? updatedAt,
  }) {
    return BlueprintState(
      items: items ?? this.items,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Returns event that is happening right now
  CalendarEvent? get currentBlueprintEvent {
    final currentEvents = items.where((event) {
      return event.startTime.isBefore(updatedAt) &&
          event.endTime.isAfter(updatedAt);
    }).toList();

    return currentEvents.firstOrNull;
  }

  Iterable<CalendarEvent> get upcomingBlueprintEvents =>
      items.where((event) => event.startTime.isAfter(updatedAt)).toList();

  Iterable<CalendarEvent> get pastBlueprintEvents =>
      items.where((event) => event.endTime.isBefore(updatedAt)).toList();

  @override
  List<Object?> get props => [items, status, updatedAt];
}
