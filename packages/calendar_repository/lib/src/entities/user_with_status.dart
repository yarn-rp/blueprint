import 'package:calendar_repository/calendar_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_with_status.g.dart';

/// {@template event_with_status}
/// A class that represents an user with an attendant status.
/// {@endtemplate}
@JsonSerializable()
class UserWithStatus {
  /// {@macro event_with_status}
  UserWithStatus(this.user, this.status);

  /// Converts a [Map<String, dynamic>] into a [UserWithStatus].
  factory UserWithStatus.fromJson(Map<String, dynamic> json) =>
      _$UserWithStatusFromJson(json);

  /// Converts a [UserWithStatus] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$UserWithStatusToJson(this);
  final User user;
  final AttendantStatus status;
}
