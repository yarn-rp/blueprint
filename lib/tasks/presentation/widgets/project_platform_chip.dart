import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class ProjectPlatformChip extends LabelChip {
  ProjectPlatformChip({
    required Task task,
    super.key,
  }) : super(
          text: task.project.platformName,
          backgroundColor: null,
          avatar: task.project.platform?.iconUrl != null
              ? Image.network(
                  task.project.platform!.iconUrl,
                  width: 24,
                  height: 24,
                )
              : null,
        );
}
