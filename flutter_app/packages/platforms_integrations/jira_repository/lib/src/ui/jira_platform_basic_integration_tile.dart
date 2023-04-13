import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jira_repository/jira_repository.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// A [PlatformIntegrationTile] that creates a [JiraBasicAuthIntegration].
class JiraPlatformBasicIntegrationTile
    extends PlatformIntegrationTile<JiraPlatform, JiraBasicAuthIntegration> {
  /// Creates a [JiraPlatformBasicIntegrationTile].
  const JiraPlatformBasicIntegrationTile({
    super.key,
    required super.platform,
    required super.onIntegrationCreated,
    required super.integrationName,
    required super.description,
  });

  @override
  Future<JiraBasicAuthIntegration?> showCreateIntegrationModal(
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
              child: _JiraBasicAuthCreateModal(
                onIntegrationCreated: onIntegrationCreated,
              ),
            ),
          );
        },
      );
}

class _JiraBasicAuthCreateModal extends StatefulWidget {
  const _JiraBasicAuthCreateModal({
    required this.onIntegrationCreated,
  });
  final FutureOr<void> Function(JiraBasicAuthIntegration) onIntegrationCreated;

  @override
  State<_JiraBasicAuthCreateModal> createState() =>
      __JiraBasicAuthCreateModalState();
}

class __JiraBasicAuthCreateModalState extends State<_JiraBasicAuthCreateModal> {
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
              const JiraBasicAuthIntegration(
                url: 'zelfio.atlassian.net',
                username: 'yrodriguez@createthrive.com',
                password:
                    'jATATT3xFfGF0IMOSAbherAiiIz2jZB-LYTFuDsxgWvdufCCpjNJOdVQU-yog-CDXwOndyQQjqs8MCiT8yRgF7ANko-dZAV6_y-l9bZZmlCNr2YhhvflsjLnrFyQyiYxVDcIyFCfRyKK4eSOS8q3IQ-jM2br4JU5Y1-BGHX8QPssTMGRYdgJqaeI=D9EE3562',
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
                  children: [
                    const Text(
                      'Jira (Basic Auth) Integration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Connect to Jira using your username and password',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Jira URL',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      onChanged: (value) => url = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid URL';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'https://example.atlassian.net',
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
                      'Jira Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your Jira username',
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
                      'Jira API Token',
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
                      'Paste your Jira API token',
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

Log in to [Jira Atlassian](https://id.atlassian.com/manage-profile/security/api-tokens).

Click Create API token.

From the dialog that appears, enter a memorable and concise Label for your token and click Create.

Click Copy to clipboard, then paste the token to your script, or elsewhere to save:''';
