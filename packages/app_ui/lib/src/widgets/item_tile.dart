import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.btnText,
    required this.backgroundColor,
    super.key,
  });
  final String title;
  final String subtitle;
  final int priority;
  final String btnText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: ListTile(
        leading: PriorityWidget(priority: priority),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xlg,
                  AppSpacing.sm,
                  AppSpacing.xlg,
                  AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(210, 230, 255, 1),
                  borderRadius: BorderRadius.circular(AppSpacing.xxxlg),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Text(
                  btnText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
