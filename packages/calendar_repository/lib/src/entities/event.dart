import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

/// {@template event}
/// A class that represents an event in the calendar.
/// {@endtemplate}
@JsonSerializable()
class Event extends Equatable {
  /// {@macro event}
  const Event({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.isAllDay,
    this.description,
    this.colorHex,
  }) : assert(
          startTime != null || isAllDay != null && isAllDay == true,
          'event should be all day or have a start date',
        );

  /// Converts a json map to an [Event] instance.
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// The start time of the event.
  final DateTime? startTime;

  /// The end time of the event.
  final DateTime? endTime;

  /// The subject of the event.
  final String subject;

  /// The description of the event.
  final String? description;

  /// Whether the event is an all day event.
  final bool? isAllDay;

  /// The color of the event in hex format.
  final String? colorHex;

  /// Converts the event to a json map.
  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        subject,
        description,
        isAllDay,
      ];
}
