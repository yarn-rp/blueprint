import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/core/utils/datetime/datetime_utils.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BlueprintModule {
  @lazySingleton
  TodaysBlueprintCubit blueprintCubit(
    SettingsBloc settingsBloc,
    CalendarRepository calendarRepository,
  ) =>
      TodaysBlueprintCubit(
        calendarRepository: calendarRepository,
        workTimes: settingsBloc
            .state.workingCalendar.events[DateTime.now().dayOfWeek]!,
      );
}
