import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

const _unknownUser = 'Unknown';

///This is the user model used to represent the final
///client of the system
@JsonSerializable()
class User {
  ///User constructor
  User({
    required this.displayName,
    required this.email,
    required this.photoURL,
  });

  ///From Json method generated in user.g.dart file
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  ///To Json method generated in user.g.dart file
  Map<String, dynamic> toJson() => _$UserToJson(this);

  ///Name that a user use in the platform
  @JsonKey(defaultValue: _unknownUser)
  final String displayName;

  ///Email of the user
  final String email;

  ///Url of the user photo
  final String? photoURL;

  /// Initials of the user name
  String get initials {
    if (displayName.isNotEmpty) {
      try {
        return displayName
            .split(' ')
            .map((e) => e[0])
            .take(2)
            .join()
            .toUpperCase();
      } catch (e) {
        return displayName[0].toUpperCase();
      }
    }
    return _unknownUser;
  }
}
