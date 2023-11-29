import 'package:bloc_test/bloc_test.dart';
import 'package:blueprint/app/app.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/settings/entities/working_calendar.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:blueprint/users/state_management/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockTodaysBlueprintCubit extends MockCubit<TodaysBlueprintState>
    implements TodaysBlueprintCubit {}

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

void main() {
  group('AppView', () {
    testWidgets('renders app Page', (tester) async {
      final authenticationBloc = MockAuthenticationCubit();
      final settingsBloc = MockSettingsBloc();
      final todaysBlueprintCubit = MockTodaysBlueprintCubit();
      final userCubit = MockUserCubit();

      when(userCubit.loadUserData).thenAnswer((_) async {});

      whenListen(
        userCubit,
        Stream.fromIterable([
          UserState.loaded(
            user: User(displayName: 'Yansaro', email: '', photoURL: ''),
          ),
        ]),
        initialState: const UserState.initial(),
      );
      whenListen(
        authenticationBloc,
        Stream.fromIterable([
          const AuthenticationState.authenticated(),
        ]),
        initialState: const AuthenticationState.authenticated(),
      );
      whenListen(
        settingsBloc,
        Stream.fromIterable([
          SettingsState(
            workingCalendar: WorkingCalendar({}),
            brightness: AppBrightness.system,
          ),
        ]),
        initialState: SettingsState(
          workingCalendar: WorkingCalendar({}),
          brightness: AppBrightness.system,
        ),
      );

      whenListen(
        todaysBlueprintCubit,
        Stream.fromIterable([
          TodaysBlueprintState.initial(
            calendarEvents: [],
            workTimes: [],
            addedAt: DateTime.now(),
          ),
        ]),
        initialState: TodaysBlueprintState.initial(
          calendarEvents: [],
          workTimes: [],
          addedAt: DateTime.now(),
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationCubit>.value(value: authenticationBloc),
            BlocProvider<SettingsBloc>.value(
              value: settingsBloc,
            ),
            BlocProvider<TodaysBlueprintCubit>.value(
              value: todaysBlueprintCubit,
            ),
            BlocProvider<UserCubit>.value(
              value: userCubit,
            ),
          ],
          child: const AppView(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
