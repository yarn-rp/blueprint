import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integrations_repository/integrations_repository.dart';

/// {@template authenticator_tile}
/// Tile to show an authenticator.
/// {@endtemplate}
class AuthenticatorTile extends StatelessWidget {
  /// {@macro authenticator_tile}
  const AuthenticatorTile({
    required this.authenticator,
    super.key,
  });

  /// The platform of the integration.
  final Authenticator authenticator;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final platform = authenticator.platform;

    return ListTile(
      title: Text(platform.displayName),
      subtitle: Text(
        authenticator.user.email ?? authenticator.user.name ?? '',
      ),
      trailing: OutlinedButton(
        onPressed: () async {
          final result = await showActionDialog<bool>(
            context: context,
            title: l10n.removeAuthenticatorConfirmationTitle,
            content: l10n.removeAuthenticatorConfirmationContent,
            actions: [
              (
                label: l10n.cancel,
                callback: (context) => Navigator.of(context).pop(),
                color: null,
              ),
              (
                label: l10n.removeCTA,
                callback: (context) => Navigator.of(context).pop(true),
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          );
          if (result ?? false) {
            if (!context.mounted) return;

            unawaited(
              context
                  .read<IntegrationsCubit>()
                  .deleteAuthenticator(authenticator),
            );
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete),
            const SizedBox(width: AppSpacing.md),
            Text(
              l10n.removeCTA,
            ),
          ],
        ),
      ),
      leading: Container(
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(2),
        child: Image.network(platform.iconUrl),
      ),
    );
  }
}
