import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class PriorityChip extends LabelChip {
  PriorityChip({
    required Task task,
    super.key,
  }) : super(
          text: switch (task.priority) {
            // handle cases from 1-5, 1 being the highest priority
            1 => 'Highest',
            2 => 'High',
            3 => 'Medium',
            4 => 'Low',
            5 => 'Lowest',
            _ => '',
          },
          backgroundColor: switch (task.priority) {
            // handle cases from 1-5, 1 being the highest priority
            1 => Colors.red,
            2 => Colors.orange,
            3 => Colors.yellow,
            4 => Colors.green,
            5 => Colors.blue,
            _ => null,
          },
          avatar: switch (task.priority) {
            // handle cases from 1-5, 1 being the highest priority
            1 => const Icon(Icons.keyboard_double_arrow_up_rounded),
            2 => const Icon(Icons.keyboard_arrow_up),
            3 => const Icon(Icons.remove),
            4 => const Icon(Icons.keyboard_arrow_down),
            5 => const Icon(Icons.keyboard_double_arrow_down),
            _ => null,
          },
        );
}
