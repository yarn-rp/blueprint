part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.changeWorkingHours(
    DaysOfWeek day,
    List<WorkTime> workingHours,
  ) = ChangeWorkingHours;

  const factory SettingsEvent.changeBrightness(
    AppBrightness brightness,
  ) = ChangeBrightness;
}
