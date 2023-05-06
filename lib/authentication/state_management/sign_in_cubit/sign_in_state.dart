part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.processing() = SignInProcessing;
  const factory SignInState.successful() = SignInSuccessful;
  const factory SignInState.error(
    Object failure,
  ) = SignInError;
}
