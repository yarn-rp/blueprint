import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:authentication_repository/src/oauth_providers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthenticationProvider {
  AppleAuthenticationProvider({
    AppleSignIn? appleSignIn,
    Cryptography? cryptography,
  })  : _appleSignIn = appleSignIn ?? AppleSignIn(),
        _cryptography = cryptography ?? Cryptography();

  final AppleSignIn _appleSignIn;
  final Cryptography _cryptography;

  Future<firebase_auth.AuthCredential> getAppleCredential() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = _cryptography.generateNonce();
    final nonce = _cryptography.sha256ofString(rawNonce);

    try {
      final appleCredential = await _appleSignIn.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential =
          firebase_auth.OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      return oauthCredential;
    } on SignInWithAppleNotSupportedException catch (exception) {
      throw AppleNotSupportedException(exception.message);
    } on SignInWithAppleAuthorizationException catch (exception) {
      switch (exception.code) {
        case AuthorizationErrorCode.canceled:
          throw UserCancelledFluxException(exception.message);
        case AuthorizationErrorCode.failed:
          throw AppleSignInException(exception.message);
        case AuthorizationErrorCode.invalidResponse:
          throw AppleSignInException(exception.message);
        case AuthorizationErrorCode.notHandled:
          throw AppleSignInException(exception.message);
        case AuthorizationErrorCode.notInteractive:
          throw AppleSignInException(exception.message);
        case AuthorizationErrorCode.unknown:
          throw AppleSignInException(exception.message);
      }
    } on SignInWithAppleException {
      throw AppleSignInException();
    }
  }
}
