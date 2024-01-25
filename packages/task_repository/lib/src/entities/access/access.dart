import 'package:integrations_repository/integrations_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access.g.dart';

@JsonSerializable()
class Access {
  const Access({
    required this.userAccessData,
    required this.platformId,
    this.platform,
  });

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);

  @JsonKey(includeFromJson: false, includeToJson: false)
  final PlatformData? platform;

  final String platformId;

  Access withPlatform(Platform platform) => Access(
        platformId: platform.id,
        platform: PlatformData(
          id: platform.id,
          displayName: platform.displayName,
          iconUrl: platform.iconUrl,
        ),
        userAccessData: userAccessData,
      );

  @JsonKey(name: 'user')
  final UserAccessData userAccessData;

  Map<String, dynamic> toJson() => _$AccessToJson(this);
}

@JsonSerializable()
class UserAccessData {
  UserAccessData({
    required this.email,
    required this.gid,
    required this.name,
  });

  factory UserAccessData.fromJson(Map<String, dynamic> json) =>
      _$UserAccessDataFromJson(json);

  final String? email;
  final String? gid;
  final String? name;

  Map<String, dynamic> toJson() => _$UserAccessDataToJson(this);
}

class PlatformData {
  PlatformData({
    required this.id,
    required this.displayName,
    required this.iconUrl,
  });

  /// The kick-off id.
  final String id;

  /// The display name of the platform.
  final String displayName;

  /// The URL of the icon for the platform.
  final String iconUrl;
}
