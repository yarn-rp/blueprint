import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// A [PlatformIntegrationTile] that creates a [GitHubTokenAuthIntegration].
class GitHubPlatformTokenIntegrationTile extends PlatformIntegrationTile<
    GitHubPlatform, GitHubTokenAuthIntegration> {
  /// Creates a [GitHubPlatformTokenIntegrationTile].
  const GitHubPlatformTokenIntegrationTile({
    super.key,
    required super.platform,
    required super.onIntegrationCreated,
    required super.integrationName,
    required super.description,
  });

  @override
  Future<GitHubTokenAuthIntegration?> showCreateIntegrationModal(
    BuildContext context,
  ) =>
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            surfaceTintColor: Theme.of(context).canvasColor,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 1200,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: _GitHubBasicAuthCreateModal(
                onIntegrationCreated: onIntegrationCreated,
              ),
            ),
          );
        },
      );
}

class _GitHubBasicAuthCreateModal extends StatefulWidget {
  const _GitHubBasicAuthCreateModal({
    required this.onIntegrationCreated,
  });
  final FutureOr<void> Function(GitHubTokenAuthIntegration)
      onIntegrationCreated;

  @override
  State<_GitHubBasicAuthCreateModal> createState() =>
      __GitHubBasicAuthCreateModalState();
}

class __GitHubBasicAuthCreateModalState
    extends State<_GitHubBasicAuthCreateModal> {
  String? token;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            widget.onIntegrationCreated(
              const GitHubTokenAuthIntegration(
                token: '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',
              ),
            );
            Navigator.of(context).pop();
          }
        },
        label: const Text(
          'Save Integration',
        ),
      ),
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: const [
          CloseButton(),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'GitHub (Token Auth) Integration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Connect to GitHub using your Token',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            // Instructions for adding the username
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GitHub Token',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your GitHub Token',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid token';
                        }

                        return null;
                      },
                      onChanged: (value) => token = value,
                      decoration: const InputDecoration(
                        hintText: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
