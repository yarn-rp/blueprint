import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

///This is the user model used to represent the final
///client of the system
@JsonSerializable()
class User {
  ///User constructor
  User({
    required String? displayName,
    required this.email,
    required this.photoURL,
  }) : _displayName = displayName ?? email.split('@').first;

  ///From Json method generated in user.g.dart file
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  ///To Json method generated in user.g.dart file
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @JsonKey(name: 'displayName')
  final String _displayName;

  ///Name that a user use in the platform
  String get displayName => _displayName;

  ///Email of the user
  final String email;

  ///Url of the user photo
  final String? photoURL;

  /// Initials of the user name
  String get initials {
    if (_displayName.isNotEmpty) {
      try {
        return _displayName
            .split(' ')
            .map((e) => e[0])
            .take(2)
            .join()
            .toUpperCase();
      } catch (e) {
        return _displayName[0].toUpperCase();
      }
    }
    return email.split('@').first[0].toUpperCase();
  }
}
