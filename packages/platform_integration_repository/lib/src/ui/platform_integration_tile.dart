import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platform_integration_repository/src/entities/entities.dart';

/// {@template platform_integration_tile}
/// A tile that shows the information of a platform integration.
/// Each platform integration has a different way of creating it, so this widget
/// is abstract and it's up to the concrete implementation to show the
/// integration creation modal.
/// {@endtemplate}
abstract class PlatformIntegrationTile<PlatformType extends Platform,
    IntegrationType extends Integration> extends StatelessWidget {
  /// {@macro platform_integration_tile}
  const PlatformIntegrationTile({
    required this.platform,
    required this.onIntegrationCreated,
    required this.integrationName,
    required this.description,
    super.key,
  });

  /// The platform of the integration.
  final Platform platform;

  /// The name of the integration.
  final String integrationName;

  /// The description of the integration.
  final String description;

  /// Called when the integration is created.
  final FutureOr<void> Function(IntegrationType) onIntegrationCreated;

  /// Shows the integration creation modal.
  Future<IntegrationType?> showCreateIntegrationModal(BuildContext context);

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
