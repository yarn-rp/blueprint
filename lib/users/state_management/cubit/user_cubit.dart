import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart' as user_model_repo;

part 'user_cubit_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepository}) : super(const UserState.initial());

  final user_model_repo.UserRepository userRepository;

  Future<void> loadUserData() async {
    emit(const UserState.loading());
    userRepository.getUserData().listen((event) {
      emit(
        UserState.loaded(user: event),
      );
    });
  }
}
