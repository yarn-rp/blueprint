import 'dart:async';

import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';

class CreateTrelloBasicAuthIntegrationCard
    extends CreateIntegrationCard<JiraBasicAuthIntegration> {
  const CreateTrelloBasicAuthIntegrationCard({
    required super.onIntegrationCreated,
    super.key,
  }) : super(
          platform: trello,
          integrationName: 'Trello',
          description: 'Connect to Trello',
        );

  @override
  Future<JiraBasicAuthIntegration?> showCreateIntegrationModal(
    BuildContext context,
  ) {
    // TODO: implement showCreateIntegrationModal
    throw UnimplementedError();
  }
}

class CreateAsanaBasicAuthIntegrationCard
    extends CreateIntegrationCard<JiraBasicAuthIntegration> {
  const CreateAsanaBasicAuthIntegrationCard({
    required super.onIntegrationCreated,
    super.key,
  }) : super(
          platform: asana,
          integrationName: 'Asana',
          description: 'Connect to Asana ',
        );

  @override
  Future<JiraBasicAuthIntegration?> showCreateIntegrationModal(
    BuildContext context,
  ) {
    // TODO: implement showCreateIntegrationModal
    throw UnimplementedError();
  }
}

class CreateOpenAIIntegrationCard
    extends CreateIntegrationCard<JiraBasicAuthIntegration> {
  const CreateOpenAIIntegrationCard({
    required super.onIntegrationCreated,
    super.key,
  }) : super(
          platform: openAI,
          integrationName: 'OpenAI (ChatGPT)',
          description: 'Connect to ChatGPT by OpenAI',
        );

  @override
  Future<JiraBasicAuthIntegration?> showCreateIntegrationModal(
    BuildContext context,
  ) {
    // TODO: implement showCreateIntegrationModal
    throw UnimplementedError();
  }
}

class CreateGithubIntegrationCard
    extends CreateIntegrationCard<JiraBasicAuthIntegration> {
  const CreateGithubIntegrationCard({
    required super.onIntegrationCreated,
    super.key,
  }) : super(
          platform: github,
          integrationName: 'Github',
          description: 'Connect to Github',
        );

  @override
  Future<JiraBasicAuthIntegration?> showCreateIntegrationModal(
    BuildContext context,
  ) {
    // TODO: implement showCreateIntegrationModal
    throw UnimplementedError();
  }
}

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
