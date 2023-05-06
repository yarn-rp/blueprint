import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepositoryContract)
      : super(
          const SignUpState.initial(),
        );

  final AuthenticationRepositoryContract _authenticationRepositoryContract;

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(const SignUpState.processing());
    try {
      await _authenticationRepositoryContract.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (isClosed) return;

      emit(
        const SignUpState.successful(),
      );
    } catch (exception) {
      emit(
        SignUpState.error(
          exception,
        ),
      );
    }
  }
}
