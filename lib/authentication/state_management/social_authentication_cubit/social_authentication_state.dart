part of 'social_authentication_cubit.dart';

/// Add a new case for each authentication provider you want to support.
///
/// This class is mean to live only in presentation layer
enum SocialAuthenticationProvider {
  google,
  apple,
  facebook;

  bool get isGoogle => this == google;
  bool get isApple => this == apple;
  bool get isFacebook => this == facebook;
}

@freezed
class SocialAuthenticationState with _$SocialAuthenticationState {
  const factory SocialAuthenticationState.idle() = IDLE;

  const factory SocialAuthenticationState.processing(
    SocialAuthenticationProvider provider,
  ) = SocialAuthenticationProcessing;

  const factory SocialAuthenticationState.success(
    SocialAuthenticationProvider provider,
  ) = SocialAuthenticationSuccess;

  const factory SocialAuthenticationState.error(
    Object failure,
    SocialAuthenticationProvider provider,
  ) = SocialAuthenticationError;
}
