import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart';
import 'package:blueprint/settings/presentation/pages/working_time_page.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const ThemeSwitcher(),
          const WorkingTime(),
          ListTile(
            title: const Text(
              'Integrations',
            ),
            subtitle: const Text('Connect with other platforms'),
            leading: const Icon(Icons.integration_instructions),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.router.push(const IntegrationsRoute()),
          ),
          BlocListener<SignOutCubit, SignOutState>(
            listener: (context, state) {
              if (state is SignOutSuccessful) {
                context.router.replaceAll([
                  const InitialRoute(),
                ]);
              }
            },
            child: ListTile(
              title: const Text('Sign out'),
              onTap: () {
                context.read<SignOutCubit>().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, AppBrightness>(
      selector: (state) => state.brightness,
      builder: (context, brightness) {
        return SwitchListTile(
          title: const Text('Enable Dark Mode'),
          value: brightness == AppBrightness.dark,
          onChanged: (bool value) {
            context.read<SettingsBloc>().add(
                  value
                      ? const ChangeBrightness(AppBrightness.dark)
                      : const ChangeBrightness(AppBrightness.system),
                );
          },
        );
      },
    );
  }
}
