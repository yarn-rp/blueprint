import 'dart:math';

import 'package:atlassian_apis/jira_platform.dart' as Jira;
import 'package:poll_e_task/tasks/entities/entities.dart';

class Mappers {
  static Project fromJiraApiProjectToProject(
    Jira.Project jiraProject,
  ) {
    final projectId = jiraProject.id;
    final projectName = jiraProject.name;
    final platformURL = jiraProject.self;
    final description = jiraProject.description;
    final color = getRandomHexColor();

    if (projectId == null) {
      throw Exception('Project ID is null');
    }
    if (projectName == null) {
      throw Exception('Project name is null');
    }
    if (platformURL == null) {
      throw Exception('Platform URL is null');
    }

    return Project(
      id: projectId,
      platformId: projectId,
      name: projectName,
      platformURL: Uri.parse(platformURL),
      description: description ?? '',
      colorHex: color,
      platform: jira,
      members: [],
    );
  }
}

String getRandomHexColor() {
  final random = Random();
  // Generate a random number between 0 and 16777215 (0xFFFFFF).
  final randomNumber = random.nextInt(0xFFFFFF);
  // Convert the random number into a Hex string.
  final hexNumber = randomNumber.toRadixString(16).padLeft(6, '0');
  // Add a '#' symbol before the Hex string to make it a valid color code.
  final hexColorCode = '#$hexNumber';
  return hexColorCode;
}
