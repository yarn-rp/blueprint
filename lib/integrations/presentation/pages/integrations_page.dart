import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:blueprint/integrations/presentation/widgets/create_integration_modals/authenticator_tile.dart';
import 'package:blueprint/integrations/presentation/widgets/create_integration_modals/platform_integration_tile.dart';
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integrations_repository/integrations_repository.dart';

@RoutePage()
class IntegrationsPage extends StatefulWidget {
  const IntegrationsPage({super.key});

  @override
  State<IntegrationsPage> createState() => _IntegrationsPageState();
}

class _IntegrationsPageState extends State<IntegrationsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isWide = MediaQuery.of(context).size.width > 1080;

    return Scaffold(
      body: isWide
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          'Integrate with new platforms',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        const AvailablePlatforms(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          'My integrations',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        const MyIntegrations(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 16),
                Text(
                  'My integrations',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const MyIntegrations(),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Integrate with new platforms',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const AvailablePlatforms(),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AvailablePlatforms extends StatelessWidget {
  const AvailablePlatforms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final availablePlatforms = context.select(
      (IntegrationsCubit cubit) => cubit.state.availablePlatforms,
    );

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        ...availablePlatforms.map((platform) {
          switch (platform.authentication) {
            case OAuth2():
              return OAuth2PlatformTile(
                platform: platform,
                integrationName: platform.displayName,
                description: l10n.oAuthPlatformTileDescription(
                  platform.displayName,
                ),
                onIntegrationCreated: (integration) {},
              );

            default:
              throw UnimplementedError(
                'Platform $platform is not implemented',
              );
          }
        }),
      ],
    );
  }
}

class MyIntegrations extends StatelessWidget {
  const MyIntegrations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final authenticators = context.select(
      (IntegrationsCubit cubit) => cubit.state.authenticators,
    );

    if (authenticators.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(
              Icons.extension_off_outlined,
              size: 120,
              color: theme.disabledColor,
            ),
            Text(
              context.l10n.noAuthenticatorsTitle,
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.noAuthenticatorsSubtitle,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        ...authenticators.map(
          (authenticator) => AuthenticatorTile(
            authenticator: authenticator,
          ),
        ),
      ],
    );
  }
}

class IntegrationCard extends StatelessWidget {
  const IntegrationCard({required this.integration, super.key});
  final Integration integration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final child = Card(
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(integration.platform.iconUrl),
                ),
              ),
              // Linear Background with an opacity of 0.75
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // context.read<IntegrationsCubit>().deleteIntegration(
                    //       integration,
                    //     );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IntegrationsDetails(integration: integration),
                ),
              ),
            ],
          ),
        );
        final isDesktop = constraints.maxWidth > 600;
        if (isDesktop) {
          // Desktop or Tablet
          return SizedBox.square(
            dimension: constraints.maxWidth / 3, // 1/3 of the screen width
            child: child,
          );
        } else {
          // Mobile
          return SizedBox.square(
            dimension: constraints.maxWidth * 3 / 4, // 3/4 of the screen width
            child: child,
          );
        }
      },
    );
  }
}

class IntegrationsDetails extends StatelessWidget {
  const IntegrationsDetails({
    required this.integration,
    super.key,
  });

  final Integration integration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          integration.platform.displayName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
