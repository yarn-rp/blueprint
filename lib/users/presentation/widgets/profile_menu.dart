import 'package:app_ui/app_ui.dart';
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/settings/presentation/pages/settings_page.dart';
import 'package:blueprint/users/state_management/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.select((UserCubit bloc) => bloc.state);

    return userState.maybeWhen(
      loaded: (user) => _UserLoaded(user: user),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _UserLoaded extends StatefulWidget {
  const _UserLoaded({
    required this.user,
  });

  final User user;

  @override
  State<_UserLoaded> createState() => _UserLoadedState();
}

class _UserLoadedState extends State<_UserLoaded> {
  late OverlayPortalController _overlayPortalController;

  @override
  void initState() {
    _overlayPortalController = OverlayPortalController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _overlayPortalController.toggle,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (BuildContext context) =>
            _UserProfileMenu(user: widget.user),
        child: _UserAvatar(
          user: widget.user,
        ),
      ),
    );
  }
}

class _UserProfileMenu extends StatelessWidget {
  const _UserProfileMenu({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Positioned(
      right: AppSpacing.xlg,
      top: AppSpacing.xxxlg,
      child: SizedBox(
        width: 400,
        child: Card(
          color: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: AvatarIcon(
                  text: user.initials,
                ),
                title: Text(user.displayName),
                subtitle: Text(user.email),
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
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return AvatarIcon(text: user.initials);
  }
}

// class ProfileMenu extends StatefulWidget {
//   const ProfileMenu({
//     required this.userDisplayName,
//     required this.userEmail,
//     required this.userInitials,
//     super.key,
//   });

//   final String userInitials;
//   final String userDisplayName;
//   final String userEmail;

//   @override
//   State<ProfileMenu> createState() => _ProfileMenuState();
// }

// class _ProfileMenuState extends State<ProfileMenu> {
//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context);
//     return BlocListener<SignOutCubit, SignOutState>(
//       listener: (context, state) {
//         if (state is SignOutSuccessful) {
//           context.router.replaceAll([
//             const InitialRoute(),
//           ]);
//         }
//       },
//       child: Column(
//         children: [
//           ListTile(
//             leading: AvatarIcon(
//               text: widget.userInitials,
//             ),
//             title: Text(widget.userDisplayName),
//             subtitle: Text(widget.userEmail),
//           ),
//           const Divider(),
//           const ThemeSwitcher(),
//           ListTile(
//             leading: const Icon(
//               Icons.exit_to_app,
//               color: Colors.red,
//             ),
//             title: Text(
//               l10n.signOut,
//               style: const TextStyle(color: Colors.red),
//             ),
//             onTap: () {
//               context.read<SignOutCubit>().signOut();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
