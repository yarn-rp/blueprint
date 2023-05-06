part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.resettingPassword({required String email}) =
      ResettingPasswordState;
  const factory ForgotPasswordState.passwordReset({
    required String email,
  }) = PasswordResetState;
  const factory ForgotPasswordState.errorResettingPassword(
    Object failure,
  ) = ErrorResettingPasswordState;
}
