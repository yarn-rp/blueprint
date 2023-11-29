import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

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

  ///From Json method genereted in user.g.dart file
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  ///To Json method genereted in user.g.dart file
  Map<String, dynamic> toJson() => _$UserToJson(this);

  ///Name that a user use in the platform
  final String displayName;

  ///Email of the user
  final String email;

  ///Url of the user photo
  final String photoURL;
}
