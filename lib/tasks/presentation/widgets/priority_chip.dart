import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class PriorityChip extends LabelChip {
  PriorityChip({
    required Task task,
    super.key,
  }) : super(
          text: getPriorityText(task.priority),
          backgroundColor: getPriorityColor(task.priority),
          avatar: Icon(getPriorityIcon(task.priority)),
        );
}

String getPriorityText(int priority) {
  return switch (priority) {
    // handle cases from 1-5, 1 being the highest priority
    1 => 'Highest',
    2 => 'High',
    3 => 'Medium',
    4 => 'Low',
    5 => 'Lowest',
    _ => '',
  };
}

Color? getPriorityColor(int priority) {
  return switch (priority) {
    // handle cases from 1-5, 1 being the highest priority
    1 => Colors.red,
    2 => Colors.orange,
    3 => Colors.yellow,
    4 => Colors.green,
    5 => Colors.blue,
    _ => null,
  };
}

IconData? getPriorityIcon(int priority) {
  return switch (priority) {
    // handle cases from 1-5, 1 being the highest priority
    1 => Icons.keyboard_double_arrow_up_rounded,
    2 => Icons.keyboard_arrow_up,
    3 => Icons.remove,
    4 => Icons.keyboard_arrow_down,
    5 => Icons.keyboard_double_arrow_down,
    _ => null,
  };
}
