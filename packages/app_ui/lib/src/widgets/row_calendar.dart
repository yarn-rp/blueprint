import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class RowCalendar extends StatelessWidget {
  const RowCalendar({
    required this.startDate,
    super.key,
  });

  final DateTime startDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.date_range),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            Jiffy(startDate).format('dd MMM yyyy hh:mm a'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
