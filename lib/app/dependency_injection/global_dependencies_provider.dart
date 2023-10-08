import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';

import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Injects all the global dependencies for the app.
class GlobalDependenciesProvider extends StatelessWidget {
  const GlobalDependenciesProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: sl<AuthenticationCubit>(),
        ),
        BlocProvider.value(
          value: sl<SettingsBloc>(),
        ),
        BlocProvider.value(
          value: sl<TasksCubit>(),
        ),
        BlocProvider.value(
          value: sl<IntegrationsCubit>(),
        ),
        BlocProvider.value(
          value: sl<TodaysBlueprintCubit>(),
        ),
      ],
      child: child,
    );
  }
}
