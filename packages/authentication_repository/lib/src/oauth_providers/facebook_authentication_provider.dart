import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthenticationProvider {
  FacebookAuthenticationProvider({FacebookAuth? facebookAuth})
      : _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  final FacebookAuth _facebookAuth;

  Future<firebase_auth.AuthCredential> getFacebookCredential() async {
    final facebookLoginResult = await _facebookAuth.login();

    switch (facebookLoginResult.status) {
      case LoginStatus.success:
        final accessToken = facebookLoginResult.accessToken;
        if (accessToken != null) {
          final facebookAuthCredential =
              firebase_auth.FacebookAuthProvider.credential(
            accessToken.token,
          );
          return facebookAuthCredential;
        } else {
          throw FacebookLoginRequestFailedException();
        }

      case LoginStatus.cancelled:
        throw UserCancelledFluxException(facebookLoginResult.message);

      case LoginStatus.failed:
        throw FacebookLoginRequestFailedException(
          facebookLoginResult.message,
        );

      case LoginStatus.operationInProgress:
        throw FacebookLoginRequestFailedException(
          facebookLoginResult.message,
        );
    }
  }

  Future<void> signOut() => _facebookAuth.logOut();
}
