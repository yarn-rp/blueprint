import 'package:auto_route/auto_route.dart';
import 'package:blueprint/integrations/state_management/cubit/integrations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_calendar_service/google_calendar_service.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';

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
          BlocBuilder<IntegrationsCubit, IntegrationsState>(
            builder: (context, state) {
              final integrations = state.calendarIntegrations;
              return Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  for (final integration in integrations)
                    Text(integration.platform.displayName),
                ],
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Integrate with new platforms',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          BlocBuilder<IntegrationsCubit, IntegrationsState>(
            builder: (context, state) {
              final platforms = state.calendarPlatforms;
              return Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  for (final platform in platforms)
                    GestureDetector(
                      onTap: () {
                        if (platform is GoogleCalendarPlatform) {
                          context
                              .read<IntegrationsCubit>()
                              .startIntegrationWithPlatform(
                                platform,
                              );
                        }
                      },
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
    if (integration is JiraIntegration) {
      return JiraIntegrationDetails(
        integration: integration as JiraIntegration,
      );
    }
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

class JiraIntegrationDetails extends StatelessWidget {
  const JiraIntegrationDetails({required this.integration, super.key});
  final JiraIntegration integration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          integration.platform.displayName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          integration.url,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          integration.user,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
