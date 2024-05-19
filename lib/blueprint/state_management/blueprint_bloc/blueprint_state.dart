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
    return items
        .where(
          (event) =>
              event.startTime.isBefore(updatedAt) &&
              event.endTime.isAfter(
                updatedAt,
              ),
        )
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Iterable<BlueprintItem> get upcomingBlueprintItems {
    return items.where((event) => event.startTime.isAfter(updatedAt)).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Iterable<BlueprintItem> get pastBlueprintItems =>
      items.where((event) => event.endTime.isBefore(updatedAt)).toList()
        ..sort(
          (a, b) => b.endTime.compareTo(a.endTime),
        );

  @override
  List<Object?> get props => [items, status, updatedAt];
}
