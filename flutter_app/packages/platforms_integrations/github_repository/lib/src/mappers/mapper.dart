import 'package:github/github.dart' as github_api;
import 'package:github_repository/src/entities/entities.dart';
import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template jira_integration_mapper}
/// Mapper in charge of mapping GitHub entities to platform integration entities.
/// {@endtemplate}
class GitHubIntegrationMapper
    extends PlatformIntegrationMapper<GitHubIntegration> {
  /// {@macro jira_integration_mapper}
  const GitHubIntegrationMapper();

  /// Maps a [github_api.Repository] to a [Project].
  Project fromGitHubApiRepositoryToProject(
    github_api.Repository repository,
    Integration integration,
  ) {
    final projectId = repository.id;
    final projectUuid = repository.id;
    final projectName = repository.name;
    final platformURL = repository.htmlUrl;
    final description = repository.description;

    final color = colorFromId(projectId.toString());

    return Project(
      id: projectUuid.toString(),
      platformId: projectId.toString(),
      name: projectName,
      platformURL: Uri.parse(platformURL),
      description: description,
      colorHex: color,
      integration: integration,
      owner: repository.owner?.login,
      slug: repository.slug().fullName,
    );
  }

  /// Maps a [GitHub.IssueBean] to a [Task].
  Task fromGitHubApiIssueToTask(
    github_api.Issue githubIssue,
    Project project,
  ) {
    final issueId = githubIssue.id;
    final createdAt = githubIssue.createdAt;
    final updatedAt = githubIssue.updatedAt;
    final taskURL = githubIssue.htmlUrl;
    final title = githubIssue.title;
    final description = githubIssue.body;
    final startDate = githubIssue.createdAt;
    final dueDate = githubIssue.closedAt;
    final estimatedTime = dueDate != null && startDate != null
        ? dueDate.difference(startDate)
        : null;

    final userCreator = fromGitHubApiUserToUser(githubIssue.user);
    final userAssigned = fromGitHubApiUserToUser(githubIssue.assignee);
    final issueState = githubIssue.state;

    final status = Status(
      issueState,
      colorFromId(
        issueState.hashCode.toString(),
      ),
    );

    final priority = extractPriority(githubIssue);
    final isCompleted = githubIssue.isClosed;

    return Task(
      id: issueId.toString(),
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      project: project,
      taskURL: Uri.parse(taskURL),
      title: title,
      description: description,
      startDate: startDate,
      dueDate: dueDate,
      estimatedTime: estimatedTime,
      loggedTime: Duration.zero,
      assigned: [if (userAssigned != null) userAssigned],
      creator: userCreator!,
      isCompleted: isCompleted,
      status: status,
      priority: priority,
    );
  }

  int extractPriority(
    github_api.Issue githubIssue,
  ) {
    var priority = 'low';
    for (final label in githubIssue.labels) {
      if (label.name.toLowerCase().contains('priority')) {
        priority = label.name.substring(label.name.indexOf(':') + 1).trim();
        break;
      }
    }

    // Handle string priorities and convert them to int from 0-5:
    // 0: Critical
    // 1: High
    // 2: Medium
    // 3: Low
    // 4: Trivial
    // 5: None
    switch (priority.toLowerCase()) {
      case 'critical':
        return 0;
      case 'high':
        return 1;
      case 'medium':
        return 2;
      case 'low':
        return 3;
      case 'trivial':
        return 4;
      case 'none':
        return 5;
      default:
        return 5;
    }
  }

  /// Maps a Map<String,dynamic> with the data of the jira api to a [User].
  User? fromGitHubApiUserToUser(github_api.User? user) {
    if (user == null) {
      return null;
    }
    final platformUrl = user.htmlUrl;
    final displayName = user.login;
    final avatarUrl = user.avatarUrl;

    return User(
      platformUrl!,
      displayName!,
      avatarUrl!,
    );
  }

  /// Maps a Map<String,dynamic> with the data of the jira api to a [Status].
  Status fromGitHubApiStatusToStatus(Map<String, dynamic>? status) {
    if (status == null) {
      return Status('No Status', '#FFC107');
    }
    final name = status['name'] as String? ?? '';
    final colorName = status['statusCategory']['colorName'] as String? ?? '';

    final color = coolColors[colorName] ?? '#FFC107';

    return Status(name, color);
  }

  int fromGitHubApiPriorityToPriority(Map<String, dynamic>? priority) {
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

  /// Maps a [GitHub.IssueBean] description to a [String].
  String fromGitHubApiDescriptionToString(
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

  /// Maps a [GitHubIntegration] to a Map<String,dynamic>.
  Map<String, dynamic> fromIntegrationToJson(
    GitHubIntegration integration,
  ) {
    if (integration is GitHubBasicAuthIntegration) {
      return integration.toJson();
    }
    if (integration is GitHubTokenAuthIntegration) {
      return integration.toJson();
    }

    throw Exception('Integration not supported');
  }

  /// Maps a Map<String,dynamic> to a [GitHubIntegration].
  /// The map must contain the key 'type' with the value 'basic_auth'.
  GitHubIntegration fromJsonToIntegration(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? '';
    if (type == 'basic_auth') {
      return GitHubBasicAuthIntegration.fromJson(json);
    }
    if (type == 'token_auth') {
      return GitHubTokenAuthIntegration.fromJson(json);
    }

    throw Exception('Integration not supported');
  }

  @override
  GitHubIntegration fromJson(Map<String, dynamic> json) =>
      fromJsonToIntegration(json);

  @override
  Map<String, dynamic> toJson(Integration integration) {
    if (integration is GitHubIntegration) {
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
