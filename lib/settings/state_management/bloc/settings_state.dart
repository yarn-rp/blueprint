// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

enum AppBrightness {
  light,
  dark,
  system;

  ThemeMode get themeMode {
    switch (this) {
      case AppBrightness.light:
        return ThemeMode.light;
      case AppBrightness.dark:
        return ThemeMode.dark;
      case AppBrightness.system:
        return ThemeMode.system;
    }
  }
}

@JsonSerializable()
class SettingsState {
  SettingsState({
    required this.workingCalendar,
    required this.brightness,
  });

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  final WorkingCalendar workingCalendar;
  final AppBrightness brightness;

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  SettingsState copyWith({
    WorkingCalendar? workingCalendar,
    AppBrightness? brightness,
  }) {
    return SettingsState(
      workingCalendar: workingCalendar ?? this.workingCalendar,
      brightness: brightness ?? this.brightness,
    );
  }
}
