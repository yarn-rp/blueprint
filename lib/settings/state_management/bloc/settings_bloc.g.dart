// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      workingCalendar: WorkingCalendar.fromJson(
          json['workingCalendar'] as Map<String, dynamic>),
      brightness: $enumDecode(_$AppBrightnessEnumMap, json['brightness']),
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'workingCalendar': instance.workingCalendar,
      'brightness': _$AppBrightnessEnumMap[instance.brightness]!,
    };

const _$AppBrightnessEnumMap = {
  AppBrightness.light: 'light',
  AppBrightness.dark: 'dark',
  AppBrightness.system: 'system',
};
