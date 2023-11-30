import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/router/app_router.dart';
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMenuView extends StatelessWidget {
  const ProfileMenuView({
    required this.userDisplayName,
    required this.userEmail,
    required this.userInitials,
    super.key,
  });
  final String userInitials;
  final String userDisplayName;
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignOutCubit>(),
      child: ProfileMenu(
        userDisplayName: userDisplayName,
        userEmail: userEmail,
        userInitials: userInitials,
      ),
    );
  }
}

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    required this.userDisplayName,
    required this.userEmail,
    required this.userInitials,
    super.key,
  });
  final String userInitials;
  final String userDisplayName;
  final String userEmail;
  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccessful) {
          context.router.replaceAll([
            const InitialRoute(),
          ]);
        }
      },
      child: Column(
        children: [
          ListTile(
            leading: AvatarIcon(
              text: widget.userInitials,
            ),
            title: Text(widget.userDisplayName),
            subtitle: Text(widget.userEmail),
          ),
          const Divider(),
          const ThemeSwitcher(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              l10n.signOut,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              context.read<SignOutCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
