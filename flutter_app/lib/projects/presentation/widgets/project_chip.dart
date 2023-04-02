import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';
import 'package:project_repository/project_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectChip extends StatelessWidget {
  const ProjectChip({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(project.platformURL),
      child: Chip(
        label: Row(
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
        backgroundColor: HexColor.fromHex(project.colorHex),
      ),
    );
  }
}
