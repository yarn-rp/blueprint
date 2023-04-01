import 'package:flutter/material.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({
    required double priority,
  }) : this._(
          priority: priority,
          showText: false,
        );

  factory PriorityWidget.label({
    required double priority,
  }) {
    return PriorityWidget._(
      priority: priority,
      showText: true,
    );
  }

  const PriorityWidget._({required this.priority, required this.showText});
  final double priority;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    final priorityLevel = (priority * 5).ceil();

    late Icon priorityIcon;
    late String priorityText;

    switch (priorityLevel) {
      case 5:
        priorityText = 'Highest';
        priorityIcon = const Icon(
          Icons.keyboard_double_arrow_up,
          color: Colors.redAccent,
        );
        break;
      case 4:
        priorityText = 'High';
        priorityIcon = const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.orangeAccent,
        );
        break;
      case 3:
        priorityText = 'Medium';
        priorityIcon = const Icon(
          Icons.remove,
          color: Colors.yellowAccent,
        );
        break;
      case 2:
        priorityText = 'Low';
        priorityIcon = const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.greenAccent,
        );
        break;
      case 1:
        priorityText = 'Lowest';
        priorityIcon = const Icon(
          Icons.keyboard_double_arrow_down,
          color: Colors.tealAccent,
        );
        break;
    }
    final avatar = CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      child: priorityIcon,
    );
    if (!showText) {
      return avatar;
    }

    return Row(
      children: [
        CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
          child: priorityIcon,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          priorityText,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
