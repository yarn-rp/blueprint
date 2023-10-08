import 'package:json_annotation/json_annotation.dart';

/// {@template attendant_status}
/// The status of the attendant in the conference
/// {@endtemplate}
@JsonEnum()
enum AttendantStatus { accepted, declined, tentative, needsAction, none }
