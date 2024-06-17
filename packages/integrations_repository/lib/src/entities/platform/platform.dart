import 'package:json_annotation/json_annotation.dart';

part 'platform.g.dart';

/// {@template platform}
/// A platform that contains the project.
/// {@endtemplate}
@JsonSerializable()
class Platform {
  /// {@macro platform}
  const Platform({
    required this.id,
    required this.displayName,
    required this.iconUrl,
    required this.authentication,
  });

  /// From json
  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);

  /// The kick-off id.
  final String id;

  /// The display name of the platform.
  @JsonKey(name: 'name')
  final String displayName;

  /// The URL of the icon for the platform.
  final String iconUrl;

  @JsonKey(
    name: 'auth',
    fromJson: Authentication.fromJson,
    toJson: Authentication.toJson,
  )
  final Authentication authentication;

  /// To json
  Map<String, dynamic> toJson() => _$PlatformToJson(this);
}

sealed class Authentication {
  const Authentication();
  factory Authentication.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'oauth2':
        return OAuth2.fromJson(json);
      case 'basic':
        return Basic.fromJson(json);
      default:
        throw Exception('Unknown type: ${json['type']}');
    }
  }

  static Map<String, dynamic> toJson(Authentication authentication) {
    return switch (authentication) {
      NoAuthentication() => {},
      Basic() => {
          'type': 'basic',
          ...authentication.toJson(),
        },
      OAuth2() => {
          ...authentication.toJson(),
          'type': 'oauth2',
        },
    };
  }
}

class NoAuthentication extends Authentication {
  const NoAuthentication();
}

@JsonSerializable()
class Basic extends Authentication {
  Basic({
    required this.username,
    required this.password,
  });
  factory Basic.fromJson(Map<String, dynamic> json) => _$BasicFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$BasicToJson(this);
}

@JsonSerializable()
class OAuth2 extends Authentication {
  OAuth2({
    required this.url,
    this.redirectScheme = 'blueprint',
  });

  factory OAuth2.fromJson(Map<String, dynamic> json) => _$OAuth2FromJson(json);

  Map<String, dynamic> toJson() => _$OAuth2ToJson(this);

  final String url;
  final String redirectScheme;
}
