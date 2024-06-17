import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:task_repository/task_repository.dart';

class ProjectPlatformChip extends LabelChip {
  ProjectPlatformChip({
    required Task task,
    super.key,
  }) : super(
          text: task.access.userAccessData.email ??
              task.access.platform!.displayName,
          backgroundColor: null,
          avatar: task.isBlueprintTask
              ? const BlueprintIcon()
              : Image.network(task.access.platform!.iconUrl),
        );
}
