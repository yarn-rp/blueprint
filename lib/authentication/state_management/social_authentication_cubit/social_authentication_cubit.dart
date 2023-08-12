import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_authentication_cubit.freezed.dart';
part 'social_authentication_state.dart';

typedef SocialAuthenticatorFunction = Future<UserModel> Function();

class SocialAuthenticationCubit extends Cubit<SocialAuthenticationState> {
  SocialAuthenticationCubit(this._authenticationRepositoryContract)
      : super(const SocialAuthenticationState.idle());

  final AuthenticationRepositoryContract _authenticationRepositoryContract;

  Future<void> continueWithGoogle() async {
    const provider = SocialAuthenticationProvider.google;
    final socialAuthenticationFunction =
        _authenticationRepositoryContract.signInWithGoogle;
    return continueWithSocial(provider, socialAuthenticationFunction);
  }

  Future<void> continueWithFacebook() async {
    const provider = SocialAuthenticationProvider.facebook;
    final socialAuthenticationFunction =
        _authenticationRepositoryContract.signInWithFacebook;
    return continueWithSocial(provider, socialAuthenticationFunction);
  }

  Future<void> continueWithApple() async {
    const provider = SocialAuthenticationProvider.apple;
    final socialAuthenticationFunction =
        _authenticationRepositoryContract.signInWithApple;
    return continueWithSocial(provider, socialAuthenticationFunction);
  }

  /// Function to handle a social authentication.
  ///
  /// Receives a [providerType] to tell states which provider is being
  /// used.
  /// Receives [socialAuthenticatorFunction] to call domain authentication
  /// fluxes depending on which provider is begin used
  @visibleForTesting
  Future<void> continueWithSocial(
    SocialAuthenticationProvider providerType,
    SocialAuthenticatorFunction socialAuthenticatorFunction,
  ) async {
    emit(
      SocialAuthenticationState.processing(providerType),
    );
    try {
      await socialAuthenticatorFunction();

      if (isClosed) return;
      emit(SocialAuthenticationState.success(providerType));
    } on UserCancelledFluxException {
      // Means that the user stopped the flux so an initial state, in this
      // case named [IDLE] for better understanding is emitted.
      emit(const SocialAuthenticationState.idle());
    } catch (exception) {
      // Just a general error state for any other failure ocurred in here.
      emit(
        SocialAuthenticationState.error(
          exception,
          providerType,
        ),
      );
    }
  }
}
