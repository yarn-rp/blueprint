import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class RichTextCard extends StatelessWidget {
  const RichTextCard({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RichTextBody(text: text),
      ),
    );
  }
}

class RichTextBody extends StatelessWidget {
  const RichTextBody({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final isBasicMD = isBasicMarkdown(text);

    if (!isBasicMD) {
      return Html(
        data: text,
        onLinkTap: (
          url,
          _,
          __,
        ) =>
            launchUrl(Uri.parse(url!)),
      );
    }
    if (text.isEmpty) {
      return const SizedBox();
    }

    return MarkdownBody(
      selectable: true,
      data: text,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        <md.InlineSyntax>[
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
      onTapLink: (String url, String? title, String? id) {
        launchUrl(Uri.parse(url));
      },
    );
  }
}

bool isBasicMarkdown(String text) {
  // List of HTML tags that are not supported by flutter_markdown
  // This is a simplified list and may not cover all unsupported tags
  final unsupportedTags = <String>[
    '<html',
    '</html>',
    '<p>',
    '</p>',
    '<script',
    '</script>',
    '<style',
    '</style>',
    '<iframe',
    '</iframe>',
    '<object',
    '</object>',
    '<embed',
    '</embed>',
    '<i>',
    '</i>',
    '<a>',
    '</a>',
    // Add more unsupported tags here
  ];

  // Check if the text contains any of the unsupported tags
  for (final tag in unsupportedTags) {
    if (text.contains(tag)) {
      return false;
    }
  }

  return true;
}
