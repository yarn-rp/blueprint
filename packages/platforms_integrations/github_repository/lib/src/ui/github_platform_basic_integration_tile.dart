import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// A [PlatformIntegrationTile] that creates a [GitHubBasicAuthIntegration].
class GitHubPlatformBasicIntegrationTile extends PlatformIntegrationTile<
    GitHubPlatform, GitHubBasicAuthIntegration> {
  /// Creates a [GitHubPlatformBasicIntegrationTile].
  const GitHubPlatformBasicIntegrationTile({
    super.key,
    required super.platform,
    required super.onIntegrationCreated,
    required super.integrationName,
    required super.description,
  });

  @override
  Future<GitHubBasicAuthIntegration?> showCreateIntegrationModal(
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
  final FutureOr<void> Function(GitHubBasicAuthIntegration)
      onIntegrationCreated;

  @override
  State<_GitHubBasicAuthCreateModal> createState() =>
      __GitHubBasicAuthCreateModalState();
}

class __GitHubBasicAuthCreateModalState
    extends State<_GitHubBasicAuthCreateModal> {
  String? url;
  String? username;
  String? token;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          log('values: $url, $username, $token');
          if (_formKey.currentState?.validate() ?? false) {
            widget.onIntegrationCreated(
              GitHubBasicAuthIntegration(
                username: username!,
                password: token!,
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
            const Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GitHub (Basic Auth) Integration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Connect to GitHub using your username and password',
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
                      'GitHub Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your GitHub username',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid username';
                        }

                        return null;
                      },
                      onChanged: (value) => username = value,
                      decoration: const InputDecoration(
                        hintText: 'johndoe@email.com',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            // Instructions for adding the token
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GitHub API Token',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      jiraTokenInstructions,
                    ),
                    // MarkdownBody(
                    //   selectable: true,
                    //   data: jiraTokenInstructions,
                    //   onTapLink: (text, href, title) {
                    //     if (href != null) {
                    //       launchUrlString(href);
                    //     }
                    //   },
                    //   extensionSet: md.ExtensionSet(
                    //     md.ExtensionSet.commonMark.blockSyntaxes,
                    //     [
                    //       md.EmojiSyntax(),
                    //     ],
                    //   ),
                    // ),
                    Image.asset('assets/docs/img/screenshot_NewAPIToken.png'),
                    const SizedBox(height: 8),
                    const Text(
                      'Paste your GitHub API token',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid API token';
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

const jiraTokenInstructions = '''

# Create an API token from your Atlassian account:

Log in to [GitHub Atlassian](https://id.atlassian.com/manage-profile/security/api-tokens).

Click Create API token.

From the dialog that appears, enter a memorable and concise Label for your token and click Create.

Click Copy to clipboard, then paste the token to your script, or elsewhere to save:''';
