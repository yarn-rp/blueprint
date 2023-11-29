part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.loading() = Loading;
  const factory UserState.loaded({required user_model_repo.User user}) = Loaded;
  const factory UserState.error(String error) = Error;
}
