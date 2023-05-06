import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authenticationRepository)
      : super(const ForgotPasswordState.initial());

  final AuthenticationRepositoryContract _authenticationRepository;

  Future<void> resetPassword(String email) async {
    // Only accept new submissions in case we are not processing a request
    if (state is ResettingPasswordState) return;

    emit(ForgotPasswordState.resettingPassword(email: email));

    try {
      await _authenticationRepository.resetPassword(email: email);

      emit(ForgotPasswordState.passwordReset(email: email));
    } catch (exception) {
      emit(
        ForgotPasswordState.errorResettingPassword(
          exception,
        ),
      );
    }
  }
}
