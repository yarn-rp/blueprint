part of 'blueprint_bloc.dart';

enum BlueprintStatus { initial, loading, loaded, error }

class BlueprintState extends Equatable {
  BlueprintState({
    List<BlueprintItem>? items,
    DateTime? updatedAt,
    this.status = BlueprintStatus.initial,
  }) {
    this.updatedAt = updatedAt ?? DateTime.now();
    this.items = (items ?? [])..sortBy((event) => event.startTime);
  }

  final BlueprintStatus status;
  late final List<BlueprintItem> items;
  late final DateTime updatedAt;

  BlueprintState copyWith({
    List<BlueprintItem>? items,
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
  BlueprintItem? get currentBlueprintItem {
    final currentEvents = items.where((event) {
      return event.startTime.isBefore(updatedAt) &&
          event.endTime.isAfter(updatedAt);
    }).toList();

    return currentEvents.firstOrNull;
  }

  Iterable<BlueprintItem> get upcomingBlueprintItems =>
      items.where((event) => event.startTime.isAfter(updatedAt)).toList();

  Iterable<BlueprintItem> get pastBlueprintItems =>
      items.where((event) => event.endTime.isBefore(updatedAt)).toList();

  @override
  List<Object?> get props => [items, status, updatedAt];
}
