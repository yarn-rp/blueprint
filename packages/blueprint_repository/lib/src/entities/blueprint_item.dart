import 'package:blueprint_repository/src/converter/timestamp_converter.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_repository/task_repository.dart';

part 'blueprint_item.freezed.dart';
part 'blueprint_item.g.dart';

/// Refers to an event that is displayed in the calendar.
@freezed
class BlueprintItem with _$BlueprintItem {
  factory BlueprintItem.fromJson(Map<String, dynamic> json) =>
      _$BlueprintItemFromJson(json);

  // Private constructor to prevent instantiation.
  const BlueprintItem._();

  const factory BlueprintItem.event({
    required Event value,
    required String id,
    @TimestampConverter() required DateTime startTime,
    @TimestampConverter() required DateTime endTime,
    @Default(false) bool isPreview,
  }) = EventBlueprintItem;

  const factory BlueprintItem.task({
    required Task value,
    required String id,
    @TimestampConverter() required DateTime startTime,
    @TimestampConverter() required DateTime endTime,
    @Default(false) bool isPreview,
  }) = TaskBlueprintItem;

  bool get isAllDay => false;

  String? get color => map(
        event: (event) => event.value.colorHex,
        task: (task) => null,
      );

  String get subject => map(
        event: (event) => event.value.subject,
        task: (task) => task.value.title,
      );
}
