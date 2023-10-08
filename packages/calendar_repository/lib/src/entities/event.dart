import 'package:calendar_repository/src/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:integrations_repository/integrations_repository.dart'
    show Platform;
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
    required this.platform,
    required this.attendantStatus,
    this.description,
    this.colorHex,
    this.organizer,
    this.attendees,
    this.platformLink,
    this.conferenceData,
  }) : assert(
          startTime != null || isAllDay != null && isAllDay == true,
          'event should be all day or have a start date',
        );

  /// Converts a [Map<String, dynamic>] into a [Event].
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// Converts a [Event] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$EventToJson(this);

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

  /// The organizer of the event.
  final User? organizer;

  /// The list of attendees of the event. The key is the email of the attendee.
  final Map<String, AttendantStatus>? attendees;

  /// The link to the event in the platform.
  final String? platformLink;

  /// The platform of the event.
  final Platform platform;

  /// The meeting data of the event. If null, means that the event is not a
  /// meeting.
  final ConferenceData? conferenceData;

  /// My status in the conference
  final AttendantStatus attendantStatus;

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        subject,
        description,
        isAllDay,
        colorHex,
        organizer,
        attendees,
        platformLink,
      ];
}
