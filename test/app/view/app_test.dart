import 'package:bloc_test/bloc_test.dart';
import 'package:blueprint/app/app.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/settings/entities/working_calendar.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockTodaysBlueprintCubit extends MockCubit<TodaysBlueprintState>
    implements TodaysBlueprintCubit {}

void main() {
  group('AppView', () {
    testWidgets('renders CounterPage', (tester) async {
      final authenticationBloc = MockAuthenticationCubit();
      final settingsBloc = MockSettingsBloc();
      final todaysBlueprintCubit = MockTodaysBlueprintCubit();

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
          ],
          child: const AppView(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
