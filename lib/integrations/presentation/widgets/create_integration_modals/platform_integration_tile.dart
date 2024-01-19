import 'dart:async';

import 'package:blueprint/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:integrations_repository/integrations_repository.dart';

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
  final FutureOr<void> Function(IntegrationType integration)
      onIntegrationCreated;

  /// Shows the integration creation modal.
  Future<IntegrationType?> showCreateIntegrationModal(BuildContext context);
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListTile(
      title: Text(integrationName),
      subtitle: Text(description),
      trailing: FilledButton(
        onPressed: () async {
          final integration = await showCreateIntegrationModal(context);
          if (integration != null) {
            await onIntegrationCreated(integration);
          }
        },
        child: Text(
          l10n.integrateCTA,
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

class OAuth2PlatformTile<PlatformType extends Platform>
    extends PlatformIntegrationTile<PlatformType, OAuth2Integration> {
  OAuth2PlatformTile({
    required super.platform,
    required super.onIntegrationCreated,
    required super.integrationName,
    required super.description,
    super.key,
  }) : assert(platform.authentication is OAuth2, 'Platform must be OAuth2');

  @override
  Future<OAuth2Integration?> showCreateIntegrationModal(
    BuildContext context,
  ) async {
    final authentication = platform.authentication as OAuth2;

    final result = await FlutterWebAuth.authenticate(
      url: authentication.url,
      callbackUrlScheme: authentication.redirectScheme,
    );

    final uri = Uri.parse(result);
    final code = uri.queryParameters['code'];
    if (code == null) {
      throw Exception('No code returned');
    }

    final integration = OAuth2Integration(platform, code);
    return integration;
  }
}
