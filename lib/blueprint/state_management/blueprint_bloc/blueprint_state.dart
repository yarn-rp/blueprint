part of 'blueprint_bloc.dart';

enum BlueprintStatus { initial, loading, loaded, error }

class BlueprintState extends Equatable {
  BlueprintState({
    this.items = const [],
    this.previewItems = const [],
    DateTime? updatedAt,
    this.status = BlueprintStatus.initial,
  }) {
    this.updatedAt = updatedAt ?? DateTime.now();
  }

  final BlueprintStatus status;
  late final List<BlueprintItem> items;
  final List<BlueprintItem> previewItems;
  late final DateTime updatedAt;

  BlueprintState copyWith({
    List<BlueprintItem>? items,
    List<BlueprintItem>? previewItems,
    BlueprintStatus? status,
    DateTime? updatedAt,
  }) {
    return BlueprintState(
      items: items ?? this.items,
      previewItems: previewItems ?? this.previewItems,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Retrieves all items already included in the blueprint and the preview
  /// items.
  Iterable<BlueprintItem> get allItems => [...items, ...previewItems];

  /// Returns event that is happening right now
  Iterable<BlueprintItem> get currentBlueprintItems {
    final now = DateTime.now();
    return items.where((event) {
      return event.startTime.isBefore(now) && event.endTime.isAfter(now);
    }).toList();
  }

  Iterable<BlueprintItem> get upcomingBlueprintItems =>
      items.where((event) => event.startTime.isAfter(updatedAt)).toList();

  Iterable<BlueprintItem> get pastBlueprintItems =>
      items.where((event) => event.endTime.isBefore(updatedAt)).toList();

  @override
  List<Object?> get props => [items, status, updatedAt];
}
