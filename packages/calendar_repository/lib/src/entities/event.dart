import 'package:calendar_repository/src/entities/entities.dart';
import 'package:calendar_repository/src/entities/user_with_status.dart';
import 'package:calendar_repository/src/utils/timestamp_converter.dart';
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
    required this.access,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.isAllDay,
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

  final Access access;

  /// The start time of the event.
  @TimestampConverter()
  final DateTime? startTime;

  /// The end time of the event.
  @TimestampConverter()
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
  final List<UserWithStatus>? attendees;

  /// The link to the event in the platform.
  final String? platformLink;

  /// The meeting data of the event. If null, means that the event is not a
  /// meeting.
  final ConferenceData? conferenceData;

  /// My status in the conference
  final AttendantStatus attendantStatus;

  Event copyWith({
    Access? access,
    DateTime? startTime,
    DateTime? endTime,
    String? subject,
    String? description,
    bool? isAllDay,
    String? colorHex,
    User? organizer,
    List<UserWithStatus>? attendees,
    String? platformLink,
    ConferenceData? conferenceData,
    AttendantStatus? attendantStatus,
  }) {
    return Event(
      access: access ?? this.access,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      isAllDay: isAllDay ?? this.isAllDay,
      colorHex: colorHex ?? this.colorHex,
      organizer: organizer ?? this.organizer,
      attendees: attendees ?? this.attendees,
      platformLink: platformLink ?? this.platformLink,
      conferenceData: conferenceData ?? this.conferenceData,
      attendantStatus: attendantStatus ?? this.attendantStatus,
    );
  }

  @override
  List<Object?> get props => [
        access,
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
