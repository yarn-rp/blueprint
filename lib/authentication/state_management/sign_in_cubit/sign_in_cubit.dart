import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository)
      : super(
          const SignInState.initial(),
        );

  final AuthenticationRepositoryContract _authenticationRepository;

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(const SignInState.processing());
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (isClosed) return;

      emit(
        const SignInState.successful(),
      );
    } catch (exception) {
      emit(
        SignInState.error(
          exception,
        ),
      );
    }
  }
}
