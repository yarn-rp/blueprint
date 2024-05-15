import 'package:authentication_repository/authentication_repository.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart';
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart';
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthenticationModule {
  @lazySingleton
  AuthenticationCubit authenticationCubit(
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      AuthenticationCubit(
        authenticationRepository,
      );

  @injectable
  SignInCubit signInCubit(
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      SignInCubit(
        authenticationRepository,
      );

  @injectable
  SignUpCubit signUpCubit(
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      SignUpCubit(
        authenticationRepository,
      );

  @injectable
  SignOutCubit signOutCubit(
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      SignOutCubit(
        authenticationRepository,
      );

  @injectable
  ForgotPasswordCubit forgotPasswordCubit(
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      ForgotPasswordCubit(
        authenticationRepository,
      );

  @lazySingleton
  AuthenticationRepositoryContract authenticationRepository(
    AppleAuthenticationProvider appleAuthenticationProvider,
    GoogleAuthenticationProvider googleAuthenticationProvider,
    FacebookAuthenticationProvider facebookAuthenticationProvider,
    FirebaseAuth firebaseAuth,
  ) =>
      AuthenticationRepository(
        appleAuthenticationProvider: appleAuthenticationProvider,
        googleAuthenticationProvider: googleAuthenticationProvider,
        facebookAuthenticationProvider: facebookAuthenticationProvider,
        firebaseAuth: firebaseAuth,
      );

  @lazySingleton
  AppleAuthenticationProvider appleAuthenticationProvider() =>
      AppleAuthenticationProvider();

  @lazySingleton
  GoogleAuthenticationProvider googleAuthenticationProvider(
    GoogleSignIn googleSignIn,
  ) =>
      GoogleAuthenticationProvider(
        googleSignIn: googleSignIn,
      );

  @lazySingleton
  FacebookAuthenticationProvider facebookAuthenticationProvider() =>
      FacebookAuthenticationProvider();
}
