import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:poll_e_task/integrations/state_management/cubit/integrations_cubit.dart';

class IntegrationsPage extends StatefulWidget {
  const IntegrationsPage({super.key});

  @override
  State<IntegrationsPage> createState() => _IntegrationsPageState();
}

class _IntegrationsPageState extends State<IntegrationsPage> {
  @override
  void initState() {
    context.read<IntegrationsCubit>().getIntegrations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntegrationsCubit, IntegrationsState>(
      builder: (context, state) {
        final integrations = state.integrations;
        return Scaffold(
          body: GridView.builder(
            itemCount: integrations.length + 1,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              maxCrossAxisExtent: 500,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == integrations.length) {
                return const Card(
                  child: Center(
                    child: Text('Add new project'),
                  ),
                );
              }
              final integration = integrations[index];
              return IntegrationCard(
                integration: integration,
              );
            },
          ),
        );
      },
    );
  }
}

class IntegrationCard extends StatelessWidget {
  const IntegrationCard({super.key, required this.integration});
  final Integration integration;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Integration with ${integration.platform.displayName}'),
    );
  }
}
