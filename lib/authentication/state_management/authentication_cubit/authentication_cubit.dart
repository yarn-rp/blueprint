import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._authenticationRepository)
      : super(
          const AuthenticationState.initial(),
        ) {
    _setupStream();
  }

  void _setupStream() => _authenticationRepository.authenticationStream
      .map(toAuthenticationState)
      .listen(emit);

  @visibleForTesting
  AuthenticationState toAuthenticationState(
    UserModel? user,
  ) =>
      user == null
          ? const AuthenticationState.unAuthenticated()
          : const AuthenticationState.authenticated();

  final AuthenticationRepositoryContract _authenticationRepository;
}
