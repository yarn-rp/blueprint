import 'package:authentication_repository/authentication_repository.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/core/utils/datetime/datetime_utils.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @lazySingleton
  BlueprintRepository blueprintRepository(
    FirebaseFirestore firestore,
    AuthenticationRepositoryContract authenticationRepository,
  ) =>
      BlueprintRepository(
        firestore: firestore,
        currentUserIdStream: authenticationRepository.authenticationStream
            .map((event) => event?.id),
      );
}
