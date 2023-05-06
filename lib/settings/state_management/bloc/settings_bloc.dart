import 'package:blueprint/settings/entities/working_calendar.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_bloc.freezed.dart';
part 'settings_bloc.g.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
          SettingsState(
            workingCalendar: WorkingCalendar({
              // Weekdays from 9 to 5
              for (final day in DaysOfWeek.values)
                if (day != DaysOfWeek.saturday && day != DaysOfWeek.sunday)
                  day: [
                    WorkTime(
                      start: const TimeOfDay(hour: 9, minute: 0),
                      end: const TimeOfDay(hour: 17, minute: 0),
                    ),
                  ]
                else
                  day: [],
            }),
            brightness: AppBrightness.system,
          ),
        ) {
    on<ChangeWorkingHours>(changeWorkingHours);
    on<ChangeBrightness>(changeBrightness);
  }

  void changeBrightness(ChangeBrightness event, Emitter<SettingsState> emit) =>
      emit(state.copyWith(brightness: event.brightness));

  void changeWorkingHours(
    ChangeWorkingHours event,
    Emitter<SettingsState> emit,
  ) {
    final newEvents = {
      ...state.workingCalendar.events,
      event.day: event.workingHours,
    };
    emit(state.copyWith(workingCalendar: WorkingCalendar(newEvents)));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
