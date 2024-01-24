import 'package:app_ui/app_ui.dart';
import 'package:image_network/image_network.dart';
import 'package:task_repository/task_repository.dart';

class ProjectPlatformChip extends LabelChip {
  ProjectPlatformChip({
    required Task task,
    super.key,
  }) : super(
          text: task.project.platformName,
          backgroundColor: null,
          avatar: task.project.platform?.iconUrl != null
              ? ImageNetwork(
                  image: task.project.platform!.iconUrl,
                  width: 24,
                  height: 24,
                )
              : null,
        );
}
