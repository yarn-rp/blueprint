const kGoogleProviderId = 'google.com';
const kAppleProviderId = 'apple.com';
const kFacebookProviderId = 'facebook.com';
const displayGoogle = 'Google';
const displayFacebook = 'Facebook';
const displayApple = 'Apple';

/// Refers to the oauth type.
///
/// Add as many types as providers app support.
enum OAuthProviderType {
  google(kGoogleProviderId, displayGoogle),
  facebook(kFacebookProviderId, displayFacebook),
  apple(kAppleProviderId, displayApple),
  unknown('unknown', 'unknown');

  const OAuthProviderType(this.id, this.name);

  final String id;
  final String name;

  static OAuthProviderType fromRawProvider(String? providerId) {
    switch (providerId) {
      case kGoogleProviderId:
        return OAuthProviderType.google;
      case kAppleProviderId:
        return OAuthProviderType.apple;
      case kFacebookProviderId:
        return OAuthProviderType.facebook;

      default:
        return OAuthProviderType.unknown;
    }
  }
}
