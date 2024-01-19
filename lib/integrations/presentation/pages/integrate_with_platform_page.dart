import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/js.dart' as js;

/// {@template integrate_with_platform_page}
/// A page that allows users to integrate with various platforms.
/// {@endtemplate}

@RoutePage()
class IntegrateWithPlatformPage extends StatelessWidget {
  /// {@macro integrate_with_platform_page}
  const IntegrateWithPlatformPage({
    @pathParam required this.platformId,
    @queryParam this.code,
    super.key,
  });

  final String platformId;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<IntegrationsCubit>()
        ..integrateWithPlatform(
          platformId,
          {'code': code},
        ),
      child: const IntegrateWithPlatformView(),
    );
  }
}

/// {@template integrate_with_platform_view}
/// View for integrating with a platform.
/// {@endtemplate}
class IntegrateWithPlatformView extends StatelessWidget {
  /// {@macro integrate_with_platform_view}
  const IntegrateWithPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: BlocBuilder<IntegrationsCubit, IntegrationsState>(
        buildWhen: (previous, current) =>
            previous.maybeMap(
              integratedPlatform: (state) => state.platformId,
              orElse: () => null,
            ) !=
            current.maybeMap(
              integratedPlatform: (state) => state.platformId,
              orElse: () => null,
            ),
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (state) => Center(
              child: Text(l10n.unexpectedError(state.message)),
            ),
            loaded: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            integratedPlatform: (state) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    size: 120,
                    color: theme.colorScheme.outline,
                  ),
                  Text(
                    l10n.integrationCompletedTitle(state.platformId),
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: Text(
                      l10n.integrationCompletedDescription(state.platformId),
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: () {
                      // close tab
                      if (kIsWeb)
                        js.context.callMethod('close');
                      else {
                        context.navigateTo(const InitialRoute());
                      }
                    },
                    child: Text(l10n.closeTabCTA),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
