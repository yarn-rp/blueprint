import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectChip extends StatelessWidget {
  const ProjectChip({
    required this.project,
    super.key,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(project.platformURL),
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: project.integration.platform.iconUrl,
              height: 16,
            ),
            const SizedBox(width: 8),
            Text(
              project.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
