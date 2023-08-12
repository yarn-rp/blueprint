part of 'available_platforms_cubit.dart';

@freezed
class AvailablePlatformsState with _$AvailablePlatformsState {
  const factory AvailablePlatformsState.initial() = _Initial;
  const factory AvailablePlatformsState.loading() = _Loading;
  const factory AvailablePlatformsState.loaded(Iterable<Platform> platforms) =
      _Loaded;

  const factory AvailablePlatformsState.error(String message) = _Error;
}
