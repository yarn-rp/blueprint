import 'dart:async';

import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';

abstract class CreateIntegrationCard<T extends Integration>
    extends StatelessWidget {
  const CreateIntegrationCard({
    required this.platform,
    required this.onIntegrationCreated,
    required this.integrationName,
    required this.description,
    super.key,
  });

  /// The platform of the integration.
  final Platform platform;

  final String integrationName;

  final String description;

  /// Called when the integration is created.
  final FutureOr<void> Function(T) onIntegrationCreated;

  Future<T?> showCreateIntegrationModal(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final integration = await showCreateIntegrationModal(context);
        if (integration != null) {
          await onIntegrationCreated(integration);
        }
      },
      title: Text(integrationName),
      subtitle: Text(description),
      trailing: ElevatedButton(
        onPressed: () async {
          final integration = await showCreateIntegrationModal(context);
          if (integration != null) {
            await onIntegrationCreated(integration);
          }
        },
        child: const Text('Integrate'),
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
