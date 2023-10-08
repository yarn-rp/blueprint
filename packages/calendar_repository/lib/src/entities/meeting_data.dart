import 'package:calendar_repository/src/entities/entry_point.dart';
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

  /// Converts a [Map<String, dynamic>] into a [ConferenceData].
  factory ConferenceData.fromJson(Map<String, dynamic> json) =>
      _$ConferenceDataFromJson(json);

  /// Converts a [ConferenceData] into a [Map<String, dynamic>].
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
