/// A representation of an event in the database
typedef EventModel = ({
  /// The start time of the event.
  DateTime? startTime,

  /// The end time of the event.
  DateTime? endTime,

  /// The subject of the event.
  String subject,

  /// The description of the event.
  String? description,

  /// Whether the event is an all day event.
  bool? isAllDay,

  /// The color of the event in hex format.
  String? colorHex,

  /// The organizer of the event.
  EventUser? organizer,

  /// The list of attendees of the event. The key is the email of the attendee.
  Map<String, AttendantStatus>? attendees,

  /// The link to the event in the platform.
  String? platformLink,

  /// The calendar platform of the event.
  Calendar calendar,

  /// The meeting data of the event. If null, means that the event is not a
  /// meeting.
  ConferenceData? conferenceData,

  /// My status in the conference
  AttendantStatus attendantStatus,
});

/// The user on the event context
typedef EventUser = ({
  /// The user's name
  String name,

  /// The user's email
  String email,
});

/// The meeting data of the event. If null, means that the event is not a
/// meeting.
typedef ConferenceData = ({
  /// The conference id
  String id,

  /// The conference link
  String link,

  /// The conference signature
  String signature,

  /// The conference password
  String password,
});

enum AttendantStatus {
  /// The user has been invited to the event.
  invited,

  /// The user has accepted the event.
  accepted,

  /// The user has declined the event.
  declined,

  /// The user has tentatively accepted the event.
  tentative,

  /// The user has not responded to the event.
  needsAction,
}

/// The calendar the event is from
typedef Calendar = ({
  /// The calendar's name
  String name,

  /// The calendar's id
  String id,

  /// The calendar's platform
  String platformName,
});
