import 'package:authentication_repository/src/models/oauth_provider_type.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// Just a wrapper for [firebase_auth.AuthCredential] so we can expose
/// functionality without importing package.
class AuthCredential {
  // ignore: public_member_api_docs
  AuthCredential({
    String? providerId,
    required this.signInMethod,
    this.token,
    this.accessToken,
  }) : provider = OAuthProviderType.fromRawProvider(providerId);

  /// Takes a credential from firebase and returns and internal package
  /// [AuthCredential] credential
  factory AuthCredential.fromAuthCredential(
    firebase_auth.AuthCredential credential,
  ) =>
      AuthCredential(
        providerId: credential.providerId,
        signInMethod: credential.signInMethod,
        token: credential.token,
        accessToken: credential.accessToken,
      );

  final String? accessToken;

  /// OAuthProvider
  final OAuthProviderType provider;

  final String signInMethod;
  final int? token;

  /// Maps package credential to [firebase_auth.AuthCredential]
  firebase_auth.AuthCredential get toAuthCredential =>
      firebase_auth.AuthCredential(
        providerId: provider.id,
        signInMethod: signInMethod,
      );
}
