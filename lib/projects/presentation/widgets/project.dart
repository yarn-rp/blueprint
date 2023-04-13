import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:blueprint/core/utils/color/hex_color_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: HexColor.fromHex(
                project.colorHex,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    project.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (project.iconUrl != null)
                    CachedNetworkImage(
                      imageUrl: project.iconUrl!,
                      height: 32,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (project.description.isNotEmpty)
                  Text(
                    project.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Platform:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CachedNetworkImage(
                      imageUrl: project.integration.platform.iconUrl,
                      height: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      project.integration.platform.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FilledButton.icon(
                onPressed: () => launchUrl(project.platformURL),
                icon: const Icon(Icons.link),
                label:
                    Text('View in ${project.integration.platform.displayName}'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
