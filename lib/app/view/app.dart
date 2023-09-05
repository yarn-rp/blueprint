import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/core/styles/styles.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter(
      authenticationCubit: context.read<AuthenticationCubit>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocSelector<SettingsBloc, SettingsState, AppBrightness>(
          selector: (state) => state.brightness,
          builder: (context, brightness) {
            // make sure you don't initiate your router
            // inside of the build function.
            return MaterialApp.router(
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: lightColorScheme,
                textTheme: textTheme,
              ),
              themeMode: brightness.themeMode,
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: darkColorScheme,
                textTheme: textTheme,
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: appRouter.config(),
            );
          },
        );
      },
    );
  }
}
