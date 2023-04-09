import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';
import 'package:poll_e_task/integrations/state_management/cubit/integrations_cubit.dart';

class IntegrationsPage extends StatefulWidget {
  const IntegrationsPage({super.key});

  @override
  State<IntegrationsPage> createState() => _IntegrationsPageState();
}

class _IntegrationsPageState extends State<IntegrationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Text(
            'My integrations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          BlocBuilder<IntegrationsCubit, IntegrationsState>(
            builder: (context, state) {
              final integrations = state.integrations;
              return Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  ...integrations.map(
                    (integration) => IntegrationCard(integration: integration),
                  ),
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
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              ...context.read<IntegrationsRepository>().getIntegrationTiles(
                    context.read<IntegrationsCubit>().addIntegration,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class IntegrationCard extends StatelessWidget {
  const IntegrationCard({super.key, required this.integration});
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
                    context.read<IntegrationsCubit>().deleteIntegration(
                          integration,
                        );
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
    super.key,
    required this.integration,
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
  const JiraIntegrationDetails({super.key, required this.integration});
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
