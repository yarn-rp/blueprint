import 'package:atlassian_apis/jira_platform.dart' as Jira;
import 'package:jira_repository/jira_repository.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template jira_integration_mapper}
/// Mapper in charge of mapping Jira entities to platform integration entities.
/// {@endtemplate}
class JiraIntegrationMapper extends PlatformIntegrationMapper<JiraIntegration> {
  const JiraIntegrationMapper();

  /// Maps a [Jira.Project] to a [Project].
  Project fromJiraApiProjectToProject(
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

  /// Maps a [Jira.IssueBean] to a [Task].
  Task fromJiraApiIssueToTask(
    Jira.IssueBean jiraIssue,
    Project project,
  ) {
    if (jiraIssue.fields == null) {
      throw Exception('Issue fields are null');
    }
    final issueId = jiraIssue.id;
    final fields = jiraIssue.fields!;

    final createdAt = fields['created'] as String;
    final updatedAt = fields['updated'] as String;
    final taskURL = fields['self'] as String? ?? '';
    final title = fields['summary'] as String? ?? '';
    final description = fromJiraApiDescriptionToString(
      fields['description'] as Map<String, dynamic>?,
    );
    final startDate = fields['startDate'] as String?;
    final dueDate = fields['dueDate'] as String?;
    final estimatedTime = fields['timeestimate'] as int?;
    final loggedTime = fields['timespent'] as int?;
    final assigned = fields['assignee'];
    final creator = fields['creator'];
    final isCompleted = fields['status']['statusCategory']['key'] == 'done';
    final status =
        fromJiraApiStatusToStatus(fields['status'] as Map<String, dynamic>?);
    final priority = fromJiraApiPriorityToPriority(
      fields['priority'] as Map<String, dynamic>?,
    );

    final userCreator = fromJiraApiUserToUser(creator as Map<String, dynamic>?);
    if (userCreator == null) {
      throw Exception('User creator is null');
    }
    final userAssigned =
        fromJiraApiUserToUser(assigned as Map<String, dynamic>?);

    return Task(
      id: issueId!,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      project: project,
      taskURL: Uri.parse(taskURL),
      title: title,
      description: description,
      startDate: startDate != null ? DateTime.parse(startDate) : null,
      dueDate: dueDate != null ? DateTime.parse(dueDate) : null,
      estimatedTime:
          estimatedTime != null ? Duration(seconds: estimatedTime) : null,
      loggedTime:
          loggedTime != null ? Duration(seconds: loggedTime) : Duration.zero,
      assigned: [if (userAssigned != null) userAssigned],
      creator: userCreator,
      isCompleted: isCompleted,
      labels: [status],
      priority: priority,
    );
  }

  /// Maps a Map<String,dynamic> with the data of the jira api to a [User].
  User? fromJiraApiUserToUser(Map<String, dynamic>? user) {
    if (user == null) {
      return null;
    }
    final platformUrl = user['self'] as String? ?? '';
    final displayName = user['displayName'] as String? ?? '';
    final avatarUrl = user['avatarUrls']['48x48'] as String? ?? '';

    return User(
      platformUrl,
      displayName,
      avatarUrl,
    );
  }

  /// Maps a Map<String,dynamic> with the data of the jira api to a [Status].
  Label fromJiraApiStatusToStatus(Map<String, dynamic>? status) {
    if (status == null) {
      return Label('No Status', '#FFC107');
    }
    final name = status['name'] as String? ?? '';
    final colorName = status['statusCategory']['colorName'] as String? ?? '';

    final color = coolColors[colorName] ?? '#FFC107';

    return Label(name, color);
  }

  int fromJiraApiPriorityToPriority(Map<String, dynamic>? priority) {
    if (priority == null) {
      return 0;
    }

    final priorityNumber = priority['id'];
    if (priorityNumber is int) {
      return priorityNumber;
    }
    final priorityInt = int.tryParse(priorityNumber as String) ?? 0;

    return priorityInt;
  }

  /// Maps a [Jira.IssueBean] description to a [String].
  String fromJiraApiDescriptionToString(
    Map<String, dynamic>? descriptionField,
  ) {
    late final String description;
    if (descriptionField == null) {
      description = '';
    } else {
      final descriptionContent = descriptionField['content'] as List;

      description = descriptionContent.map((e) {
        final content = e['content'] as List?;
        if (content == null) {
          return '';
        }
        return content.map((e) => e['text'] as String? ?? '').join('\n');
      }).join('\r');
    }

    return description;
  }

  /// Maps a [JiraIntegration] to a Map<String,dynamic>.
  Map<String, dynamic> fromIntegrationToJson(
    JiraIntegration integration,
  ) {
    if (integration is JiraBasicAuthIntegration) {
      return integration.toJson();
    }

    throw Exception('Integration not supported');
  }

  /// Maps a Map<String,dynamic> to a [JiraIntegration].
  /// The map must contain the key 'type' with the value 'basic_auth'.
  JiraIntegration fromJsonToIntegration(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? '';
    if (type == 'basic_auth') {
      return JiraBasicAuthIntegration.fromJson(json);
    }

    throw Exception('Integration not supported');
  }

  @override
  JiraIntegration fromJson(Map<String, dynamic> json) {
    return fromJsonToIntegration(json);
  }

  @override
  Map<String, dynamic> toJson(Integration integration) {
    if (integration is JiraIntegration) {
      return fromIntegrationToJson(integration);
    }

    throw Exception('Integration not supported');
  }
}

/// Hash function that given an id returns a MaterialColor.
/// This color is unique for each id.
String colorFromId(String id) {
  final hash = id.hashCode;
  final index = hash % coolColors.length;

  return coolColors.values.elementAt(index);
}
