import 'package:app_ui/app_ui.dart';
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/settings/presentation/pages/settings_page.dart';
import 'package:blueprint/users/state_management/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:user_repository/user_repository.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.select((UserCubit bloc) => bloc.state);

    return userState.maybeWhen(
      loaded: (user) => _UserLoaded(user: user),
      // this is a hack for the different envs using development firebase
      // credentials.
      orElse: () => const _SignOutButton(),
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
  late bool _isVisible;

  @override
  void initState() {
    _isVisible = false;
    super.initState();
  }

  void togglePortal() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void hidePortal() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePortal,
      child: PortalTarget(
        visible: _isVisible,
        closeDuration: kThemeAnimationDuration,
        anchor: const Aligned(
          follower: Alignment.topRight,
          target: Alignment.topRight,
        ),
        portalFollower: Stack(
          alignment: Alignment.topRight,
          children: [
            Barrier(
              visible: _isVisible,
              onClose: hidePortal,
            ),
            Positioned(
              top: AppSpacing.xxxlg,
              right: AppSpacing.md,
              child: TweenAnimationBuilder<double>(
                duration: kThemeAnimationDuration,
                curve: Curves.easeOut,
                tween: Tween(begin: 0, end: _isVisible ? 1 : 0),
                builder: (context, opacity, _) => Opacity(
                  opacity: opacity,
                  child: _UserProfileMenu(user: widget.user),
                ),
              ),
            ),
          ],
        ),
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
        child: Material(
          color: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black,
          elevation: 14,
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

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<SignOutCubit>().signOut();
      },
      icon: const Icon(
        Icons.exit_to_app,
      ),
    );
  }
}
