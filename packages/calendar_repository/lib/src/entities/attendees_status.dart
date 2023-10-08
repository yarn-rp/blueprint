import 'package:json_annotation/json_annotation.dart';

/// {@template attendant_status}
/// The status of the attendant in the conference
/// {@endtemplate}
@JsonEnum()
enum AttendantStatus {
  /// The attendant has accepted the invitation
  accepted,

  /// The attendant has declined the invitation
  declined,

  /// The attendant has not confirmed that is attending, but it did received
  /// the invitation and decided to mark it as tentative
  tentative,

  /// The attendant has been invited but has not responded yet. The main
  /// difference between this status and [tentative] is that the attendant
  /// has not seen the invitation yet
  needsAction,

  /// The status is unknown
  none;
}
