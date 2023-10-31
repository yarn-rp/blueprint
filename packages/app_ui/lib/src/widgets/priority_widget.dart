import 'package:flutter/material.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({
    required int priority,
  }) : this._(
          priority: priority,
          showText: false,
        );

  factory PriorityWidget.label({
    required int priority,
  }) {
    return PriorityWidget._(
      priority: priority,
      showText: true,
    );
  }

  const PriorityWidget._({required this.priority, required this.showText});
  final int priority;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    final priorityLevel = priority;

    late Icon priorityIcon;
    late String priorityText;

    switch (priorityLevel) {
      // handle cases from 1-5, 1 being the highest priority
      case 1:
        priorityIcon = const Icon(
          Icons.keyboard_double_arrow_up,
          color: Colors.red,
        );
        priorityText = 'Highest';

      case 2:
        priorityIcon = const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.orange,
        );
        priorityText = 'High';

      case 3:
        priorityIcon = const Icon(
          Icons.remove,
          color: Colors.yellow,
        );
        priorityText = 'Medium';

      case 4:
        priorityIcon = const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.green,
        );
        priorityText = 'Low';

      case 5:
        priorityIcon = const Icon(
          Icons.keyboard_double_arrow_down,
          color: Colors.blue,
        );
        priorityText = 'Lowest';
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
