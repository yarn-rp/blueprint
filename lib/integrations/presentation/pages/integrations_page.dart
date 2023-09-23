import 'package:auto_route/auto_route.dart';
import 'package:blueprint/integrations/presentation/widgets/platform_integration_tile.dart';
import 'package:blueprint/integrations/state_management/available_platforms/available_platforms_cubit.dart';
import 'package:blueprint/integrations/state_management/integrations_cubit/integrations_cubit.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrations'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Text(
            'My integrations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // BlocBuilder<IntegrationsCubit, IntegrationsState>(
          //   builder: (context, state) {
          //     final integrations = state.calendarIntegrations;
          //     return Wrap(
          //       runSpacing: 16,
          //       spacing: 16,
          //       children: [
          //         for (final integration in integrations)
          //           Text(integration.platform.displayName),
          //       ],
          //     );
          //   },
          // ),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Integrate with new platforms',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          BlocBuilder<AvailablePlatformsCubit, AvailablePlatformsState>(
            builder: (context, state) {
              return state.map(
                initial: (_) => const SizedBox.shrink(),
                loading: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (state) => Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: [
                    ...state.platforms.map((platform) {
                      switch (platform.authentication) {
                        case OAuth2():
                          return OAuth2PlatformTile(
                            platform: platform,
                            integrationName: platform.displayName,
                            description:
                                'Connect your ${platform.displayName} account to Blueprint',
                            onIntegrationCreated: (integration) {
                              // context
                              //     .read<IntegrationsCubit>()
                              //     .addIntegration(integration);
                            },
                          );

                        default:
                          throw UnimplementedError(
                            'Platform $platform is not implemented',
                          );
                      }
                    }),
                  ],
                ),
                error: (_) => const Center(
                  child: Text('Error loading platforms'),
                ),
              );
            },
          ),
          BlocBuilder<IntegrationsCubit, IntegrationsState>(
            builder: (context, state) {
              final platforms = state.platforms;
              return Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  for (final platform in platforms)
                    GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Image.network(platform.iconUrl),
                              const SizedBox(height: 16),
                              Text(
                                platform.displayName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
