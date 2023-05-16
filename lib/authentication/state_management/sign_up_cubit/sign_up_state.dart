part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.processing() = SignUpProcessing;
  const factory SignUpState.successful() = SignUpSuccessful;
  const factory SignUpState.error(
    Object failure,
  ) = SignUpError;
}
