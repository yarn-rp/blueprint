import 'package:json_annotation/json_annotation.dart';

part 'meeting_data.g.dart';

/// {@template conference_data}
/// Contains information of the conference event
/// {@endtemplate}
@JsonSerializable()
class ConferenceData {
  /// {@macro conference_data}
  ConferenceData({
    required this.entryPoints,
    required this.notes,
  });

  /// Converts a [Map<String, dynamic>] to a [ConferenceData].
  factory ConferenceData.fromJson(Map<String, dynamic> json) =>
      _$ConferenceDataFromJson(json);

  /// Converts a [ConferenceData] to a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ConferenceDataToJson(this);

  /// Information about individual conference entry points, such as URLs or
  /// phone numbers.
  /// All of them must belong to the same conference.
  /// Either conferenceSolution and at least one entryPoint, or createRequest is
  /// required.
  Iterable<EntryPoint> entryPoints;

  /// Additional notes (such as instructions from the domain administrator,
  /// legal notices) to display to the user.
  ///
  /// Can contain HTML. The maximum length is 2048 characters. Optional.
  String? notes;
}

/// {@template entry_point}
/// The entry point to the conference.
/// {@endtemplate}
@JsonSerializable()
class EntryPoint {
  /// {@macro entry_point}
  EntryPoint({
    required this.entryPointType,
    required this.label,
    required this.uri,
  });

  /// Converts a [Map<String, dynamic>] to a [EntryPoint].
  factory EntryPoint.fromJson(Map<String, dynamic> json) =>
      _$EntryPointFromJson(json);

  /// Converts a [EntryPoint] to a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$EntryPointToJson(this);

  /// The type of the conference entry point.
  /// Possible values are:
  /// - "video" - joining a conference over HTTP.
  ///
  /// A conference can have zero or one video entry point.
  /// - "phone" - joining a conference by dialing a phone number. A conference
  /// can have zero or more phone entry points.
  /// - "sip" - joining a conference over SIP. A conference can have zero or one
  /// sip entry point.
  /// - "more" - further conference joining instructions, for example additional
  /// phone numbers. A conference can have zero or one more entry point. A
  /// conference with only a more entry point is not a valid conference.
  String? entryPointType;

  /// The label for the URI.
  ///
  /// Visible to end users. Not localized. The maximum length is 512 characters.
  /// Examples:
  /// - for video: meet.google.com/aaa-bbbb-ccc
  /// - for phone: +1 123 268 2601
  /// - for sip: 12345678@altostrat.com
  /// - for more: should not be filled
  /// Optional.
  String? label;

  /// The URI of the entry point.
  ///
  /// The maximum length is 1300 characters.
  /// Format:
  /// - for video, http: or https: schema is required.
  /// - for phone, tel: schema is required. The URI should include the entire
  /// dial sequence (e.g., tel:+12345678900,,,123456789;1234).
  /// - for sip, sip: schema is required, e.g., sip:12345678@myprovider.com.
  /// - for more, http: or https: schema is required.
  String? uri;
}

/// {@template attendant_status}
/// The status of the attendant in the conference
/// {@endtemplate}
enum AttendantStatus { accepted, declined, tentative, needsAction, none }
