import 'package:atlassian_apis/jira_platform.dart' as Jira;
import 'package:integrations_repository/integrations_repository.dart';
import 'package:project_repository/project_repository.dart';

class Mappers {
  static Project fromJiraApiProjectToProject(
    Jira.Project jiraProject,
    Integration integration,
  ) {
    final projectId = jiraProject.id;
    final projectUuid = jiraProject.uuid;
    final projectName = jiraProject.name;
    final platformURL = jiraProject.self;
    final description = jiraProject.description;
    final iconUrl = jiraProject.avatarUrls?.$16X16;

    if (projectId == null) {
      throw Exception('Project ID is null');
    }
    if (projectUuid == null) {
      throw Exception('Project UUID is null');
    }
    if (projectName == null) {
      throw Exception('Project name is null');
    }
    if (platformURL == null) {
      throw Exception('Platform URL is null');
    }

    // log('response: ${jiraProject.toJson()}');

    final color = colorFromId(projectId);

    return Project(
      id: projectUuid,
      platformId: projectId,
      name: projectName,
      platformURL: Uri.parse(platformURL),
      description: description ?? '',
      colorHex: color,
      integration: integration,
      iconUrl: iconUrl,
    );
  }
}

/// Hash function that given an id returns a MaterialColor.
/// This color is unique for each id.
String colorFromId(String id) {
  final hash = id.hashCode;
  final index = hash % coolColors.length;

  return coolColors[index];
}
