part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.loaded({required User user}) = Loaded;
  const factory UserState.error(String error) = Error;
}
