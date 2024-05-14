import 'package:authentication_repository/src/models/models.dart';

/// {@template authentication_repository}
/// Authentication contract class
/// {@endtemplate}
abstract class AuthenticationRepositoryContract {
  /// Signs in a user given some [email] and [password] credential.
  ///
  /// Throws some exception if could not validate credential
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs up a user given some [email] and [password] credential.
  ///
  /// Throws some exception if could not validate credential
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Streams if user is authenticated or not
  ///
  /// Probably we want to expose more than the `state`, but this is for the
  /// demo, so it's simpler.
  Stream<UserModel?> get authenticationStream;

  /// Signs out current user and notifies to [authenticationStream] about
  /// this changes
  Future<void> signOut();

  Future<UserModel> signInWithApple();

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithFacebook();

  // /// Fetches all providers associated to account with [email].
  // Future<Iterable<OAuthProviderType>> getProvidersAssociatedToEmail({
  //   required String email,
  // });

  /// Sends a reset password
  Future<void> resetPassword({
    required String email,
  });

  /// Gets the current authenticated user
  ///
  /// Returns null if not user is authenticated
  UserModel? get currentUser;
}
