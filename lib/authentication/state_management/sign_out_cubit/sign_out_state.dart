part of 'sign_out_cubit.dart';

@freezed
class SignOutState with _$SignOutState {
  const factory SignOutState.initial() = _Initial;
  const factory SignOutState.processing() = SignOutProcessing;
  const factory SignOutState.successful() = SignOutSuccessful;
  const factory SignOutState.error(
    Object failure,
  ) = SignOutError;
}
