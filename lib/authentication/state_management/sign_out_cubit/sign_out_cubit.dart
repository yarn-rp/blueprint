import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_out_cubit.freezed.dart';
part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this._authenticationRepositoryContract)
      : super(const SignOutState.initial());

  final AuthenticationRepositoryContract _authenticationRepositoryContract;

  Future<void> signOut() async {
    emit(const SignOutState.processing());

    try {
      await _authenticationRepositoryContract.signOut();
      emit(
        const SignOutState.successful(),
      );
    } catch (exception) {
      emit(
        SignOutState.error(
          exception,
        ),
      );
    }
  }
}
