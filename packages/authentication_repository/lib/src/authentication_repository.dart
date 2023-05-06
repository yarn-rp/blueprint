import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';

/// {@template authentication_repository}
/// [AuthenticationRepositoryContract] implementation
/// {@endtemplate}
class AuthenticationRepository implements AuthenticationRepositoryContract {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    required AppleAuthenticationProvider appleAuthenticationProvider,
    required FacebookAuthenticationProvider facebookAuthenticationProvider,
    required GoogleAuthenticationProvider googleAuthenticationProvider,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _appleAuthenticationProvider = appleAuthenticationProvider,
        _facebookAuthenticationProvider = facebookAuthenticationProvider,
        _googleAuthenticationProvider = googleAuthenticationProvider,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final AppleAuthenticationProvider _appleAuthenticationProvider;

  final FacebookAuthenticationProvider _facebookAuthenticationProvider;

  final GoogleAuthenticationProvider _googleAuthenticationProvider;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// `user != null` means authenticated
  /// `user == null` means unauthenticated
  @override
  Stream<UserModel?> get authenticationStream {
    return _firebaseAuth.authStateChanges().map((user) {
      return user == null ? null : UserModel.fromFirebaseUser(user);
    });
  }

  @override
  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user == null ? null : UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == ErrorCodes.userNotFound) {
        throw UserNotFoundException();
      } else if (e.code == ErrorCodes.wrongPassword) {
        throw WrongPasswordException();
      } else {
        throw SignInException();
      }
    } catch (_) {
      throw SignInException();
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    late firebase_auth.AuthCredential credential;

    try {
      credential = await _appleAuthenticationProvider.getAppleCredential();
    } on UserCancelledFluxException {
      rethrow;
    } on AppleSignInException {
      rethrow;
    }
    // All exceptions above are meant to be handled by signInWithApple caller.
    catch (_) {
      throw SignInException();
    }
    final user = await signInWithCredentials(
      credential: credential,
    );
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    late firebase_auth.AuthCredential credential;

    try {
      credential = await _googleAuthenticationProvider.getGoogleCredential();
    } on UserCancelledFluxException {
      rethrow;
    }
    // All exceptions above are meant to be handled by signInWithGoogle caller.
    catch (_) {
      // If you want to map an exception from
      // _googleAuthenticationProvider.getGoogleCredential or want to rethrow
      // exceptions, please use the **on** syntax like block above
      throw SignInException();
    }
    final user = await signInWithCredentials(
      credential: credential,
    );
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    late firebase_auth.AuthCredential credential;

    try {
      credential =
          await _facebookAuthenticationProvider.getFacebookCredential();
    } on UserCancelledFluxException {
      rethrow;
    } on FacebookLoginRequestFailedException {
      rethrow;
    }
    // All exceptions above are meant to be handled by signInWithFacebook caller
    catch (_) {
      throw SignInException();
    }
    final user = await signInWithCredentials(
      credential: credential,
    );
    return UserModel.fromFirebaseUser(user);
  }

  /// SigOut from all providers no matters if error occurs.
  Future<void> _signOutFromProviders() async {
    try {
      final signOutOfProvidersFunctions = [
        _googleAuthenticationProvider.signOut,
        _facebookAuthenticationProvider.signOut,
      ];
      await Future.wait(
        signOutOfProvidersFunctions.map((e) => e().catchError((_) {})),
      );
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _signOutFromProviders();
    } on firebase_auth.FirebaseAuthException {
      throw SignOutException();
    } catch (e) {
      throw SignOutException();
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (exception) {
      if (exception.code == ErrorCodes.authInvalidEmail) {
        throw InvalidEmailException();
      }

      if (exception.code == ErrorCodes.userNotFound) {
        throw UserNotFoundException();
      }

      throw ResetPasswordException();
    } catch (exception) {
      throw ResetPasswordException();
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      } else {
        throw SignUpException();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == ErrorCodes.weakPassword) {
        throw WeakPasswordException();
      } else if (e.code == ErrorCodes.emailAlreadyUsed) {
        throw EmailAlreadyInUseException();
      } else {
        throw SignUpException();
      }
    } catch (_) {
      throw SignUpException();
    }
  }

  /// Asynchronously signs in to Firebase with the given 3rd-party credentials
  /// (e.g. a Facebook login Access Token, a Google ID Token/Access Token pair,
  /// etc.) and returns additional identity provider data.
  ///
  /// Receives a [firebase_auth.AuthCredential] which is a Firebase credential
  /// for some sign-in provider implementation.
  ///
  /// If successful, it also signs the user in into the app and updates any
  /// [authenticationStream] stream listeners.
  ///
  /// If the user doesn't have an account already, one will be created
  /// automatically.
  @protected
  @visibleForTesting
  Future<firebase_auth.User> signInWithCredentials({
    required firebase_auth.AuthCredential credential,
  }) async {
    try {
      final userCredentials =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredentials.user;
      if (user != null) {
        return user;
      } else {
        throw SignInException();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == ErrorCodes.accountExistWithDifferentCredential) {
        throw AccountExistWithDifferentCredentialException(
          credential: AuthCredential.fromAuthCredential(
            credential,
          ),
          // We can assure that at this point, not having an email is
          // completely unexpected
          email: e.email!,
        );
      }
      if (e.code == ErrorCodes.userNotFound) {
        throw UserNotFoundException();
      } else if (e.code == ErrorCodes.wrongPassword) {
        throw WrongPasswordException();
      } else {
        throw SignInException();
      }
    } catch (_) {
      throw SignInException();
    }
  }

  @override
  Future<Iterable<OAuthProviderType>> getProvidersAssociatedToEmail({
    required String email,
  }) async {
    try {
      final accountProviderIds =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      return accountProviderIds.map(OAuthProviderType.fromRawProvider);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == ErrorCodes.userNotFound) {
        throw UserNotFoundException();
      } else {
        throw ProvidersException();
      }
    } catch (e) {
      throw ProvidersException();
    }
  }
}
