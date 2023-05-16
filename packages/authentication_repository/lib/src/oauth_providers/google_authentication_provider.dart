import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthenticationProvider {
  GoogleAuthenticationProvider({GoogleSignIn? googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn();

  final GoogleSignIn _googleSignIn;
  Future<firebase_auth.AuthCredential> getGoogleCredential() async {
    final googleUser =
        _googleSignIn.currentUser ?? await _googleSignIn.signIn();
    if (googleUser == null) {
      // User cancelled the flux
      throw UserCancelledFluxException();
    }

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return credential;
  }

  /// Mark the current user like being sign out of the app.
  Future<void> signOut() async => _googleSignIn.signOut();
}
