import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Wrapper for SignInWithApple class
class AppleSignIn {
  ///Requests an Apple ID credential.

  ///Shows the native UI on Apple's platform, a Chrome Custom Tab on Android,
  ///and a popup on Websites.

  /// The returned [AuthorizationCredentialAppleID]'s authorizationCode should
  /// then be used to validate the token with Apple's servers and create a
  /// session in your system.

  ///Fields on the returned [AuthorizationCredentialAppleID] will be set based
  ///on the given scopes.
  Future<AuthorizationCredentialAppleID> getAppleIDCredential({
    required List<AppleIDAuthorizationScopes> scopes,
    WebAuthenticationOptions? webAuthenticationOptions,
    String? nonce,
    String? state,
  }) async {
    return SignInWithApple.getAppleIDCredential(
      scopes: scopes,
      nonce: nonce,
      state: state,
    );
  }
}
