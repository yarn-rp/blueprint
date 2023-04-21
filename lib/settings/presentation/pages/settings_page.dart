import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/view/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Integrations',
            ),
            subtitle: const Text('Connect with other platforms'),
            leading: const Icon(Icons.integration_instructions),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.router.push(const IntegrationsRoute()),
          ),
        ],
      ),
    );
  }
}
