import 'package:app_ui/app_ui.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:blueprint/users/state_management/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: sl<AuthenticationCubit>(),
        ),
        BlocProvider.value(value: sl<SettingsBloc>()),
        BlocProvider.value(value: sl<TasksCubit>()),
        BlocProvider.value(value: sl<IntegrationsCubit>()),
        BlocProvider.value(value: sl<TodaysBlueprintCubit>()),
        BlocProvider.value(value: sl<UserCubit>()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(
      authenticationCubit: context.read<AuthenticationCubit>(),
    );

    return Builder(
      builder: (context) {
        final brightness =
            context.select((SettingsBloc bloc) => bloc.state.brightness);

        return BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) =>
              previous is AuthenticatedState && current is UnAuthenticatedState,
          listener: (context, state) => appRouter.push(
            SignInRoute(
              onResult: ({
                bool? result,
              }) {},
            ),
          ),
          child: Portal(
            child: MaterialApp.router(
              theme: lightTheme,
              themeMode: brightness.themeMode,
              darkTheme: darkTheme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: appRouter.config(),
            ),
          ),
        );
      },
    );
  }
}
