import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'user_cubit_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserState.initial()) {
    _init();
  }

  final UserRepository _userRepository;
  late final StreamSubscription<User?> _userSubscription;

  void _init() {
    final userStream = _userRepository.getUserData();

    _userSubscription = userStream.listen(
      (user) {
        if (user == null) {
          emit(const UserState.initial());
        } else {
          emit(UserState.loaded(user: user));
        }
      },
      onError: (Object error) {
        addError(error);
        emit(UserState.error(error.toString()));
      },
      cancelOnError: false,
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
