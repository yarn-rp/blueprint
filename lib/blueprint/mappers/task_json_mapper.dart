import 'package:github_repository/github_repository.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';

abstract class TaskJsonMapper {
  static Map<String, dynamic> toJson(Task task) {
    return {
      'id': task.id,
      'name': task.title,
      'estimatedTime': task.estimatedTime?.inMilliseconds,
      'description': task.description,
      'isCompleted': task.isCompleted,
      'createdAt': task.createdAt.toIso8601String(),
      'updatedAt': task.updatedAt.toIso8601String(),
      'dueDate': task.dueDate?.toIso8601String(),
      'taskURL': task.taskURL.toString(),
      'startDate': task.startDate?.toIso8601String(),
      'loggedTime': task.loggedTime?.inMilliseconds,
      'priority': task.priority,
      'project': toJsonProject(task.project),
      'creator': toJsonUser(task.creator),
      'assigned': task.assigned
          .map(
            toJsonUser,
          )
          .toList(),
      'labels': task.labels.map(toJsonLabel).toList(),
    };
  }

  static Map<String, dynamic> toJsonLabel(Label label) {
    return {
      'name': label.name,
      'color': label.hexColor,
    };
  }

  static Map<String, dynamic> toJsonUser(User user) {
    return {
      'platformURL': user.platformUrl,
      'displayName': user.displayName,
      'avatarURL': user.avatarUrl,
    };
  }

  static Map<String, dynamic> toJsonIntegration(Integration integration) {
    if (integration is GitHubIntegration) {
      return integration.toJson();
    } else if (integration is JiraIntegration) {
      return integration.toJson();
    } else {
      throw UnimplementedError(
        'Unknown integration type: ${integration.runtimeType}',
      );
    }
  }

  static Map<String, dynamic> toJsonProject(Project project) {
    return {
      'id': project.id,
      'platformId': project.platformId,
      'platformURL': project.platformURL.toString(),
      'integration': toJsonIntegration(project.integration),
      'name': project.name,
      'description': project.description,
      'iconURL': project.iconUrl,
      'colorHex': project.colorHex,
      'owner': project.owner,
      'slug': project.slug,
    };
  }

  static Task fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        title: json['name'] as String,
        estimatedTime: json['estimatedTime'] != null
            ? Duration(milliseconds: json['estimatedTime'] as int)
            : null,
        description: json['description'] as String,
        isCompleted: json['isCompleted'] as bool,
        createdAt: DateTime.tryParse(json['createdAt'] as String)!,
        updatedAt: DateTime.tryParse(json['updatedAt'] as String)!,
        dueDate: json['dueDate'] != null
            ? DateTime.tryParse(json['dueDate'] as String)
            : null,
        taskURL: Uri.tryParse(json['taskURL'] as String)!,
        startDate: json['startDate'] != null
            ? DateTime.tryParse(json['startDate'] as String)
            : null,
        loggedTime: json['loggedTime'] != null
            ? Duration(milliseconds: json['loggedTime'] as int)
            : null,
        priority: json['priority'] as int,
        project: fromJsonProject(json['project'] as Map<String, dynamic>),
        creator: fromJsonUser(json['creator'] as Map<String, dynamic>),
        assigned: (json['assigned'] as List)
            .map((e) => fromJsonUser(e as Map<String, dynamic>))
            .toList(),
        labels: (json['labels'] as List)
            .map((e) => fromJsonLabel(e as Map<String, dynamic>))
            .toList(),
      );

  static Label fromJsonLabel(Map<String, dynamic> json) => Label(
        json['name'] as String,
        json['color'] as String,
      );

  static User fromJsonUser(Map<String, dynamic> json) => User(
        json['platformURL'] as String,
        json['displayName'] as String,
        json['avatarURL'] as String,
      );

  static Project fromJsonProject(Map<String, dynamic> json) => Project(
        id: json['id'] as String,
        platformId: json['platformId'] as String,
        platformURL: Uri.parse(json['platformURL'] as String),
        integration:
            fromJsonIntegration(json['integration'] as Map<String, dynamic>),
        name: json['name'] as String,
        description: json['description'] as String,
        colorHex: json['colorHex'] as String,
        owner: json['owner'] as String?,
        iconUrl: json['iconUrl'] as String?,
        slug: json['slug'] as String?,
      );

  static Integration fromJsonIntegration(Map<String, dynamic> json) {
    final platformId = json['platformId'] as String;
    final platform = fromJsonPlatform(platformId);

    if (platform is JiraPlatform) {
      return JiraIntegration.fromJson(json);
    } else if (platform is GitHubPlatform) {
      return GitHubIntegration.fromJson(json);
    } else {
      throw Exception('Unknown platform id: $platformId');
    }
  }

  static Platform fromJsonPlatform(String platformId) {
    switch (platformId) {
      case 'github':
        return githubPlatform;
      case 'jira':
        return jiraPlatform;
      default:
        throw Exception('Unknown platform id: $platformId');
    }
  }
}
