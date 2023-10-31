import 'package:flutter/material.dart';

class ResponsibleRow extends StatelessWidget {
  const ResponsibleRow({
    required this.platformIcon,
    required this.responsible,
    required this.progressColor,
    required this.progress,
    required this.backColorUser,
    super.key,
  });

  final String platformIcon;
  final String responsible;
  final Color progressColor;
  final String progress;
  final Color backColorUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(2, 2, 16, 2),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff303030)),
            color: backColorUser,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                width: 20,
                height: 20,
                child: Image.network(platformIcon),
              ),
              Text(
                responsible,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(2, 2, 16, 2),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff303030)),
            color: progressColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                progress,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
