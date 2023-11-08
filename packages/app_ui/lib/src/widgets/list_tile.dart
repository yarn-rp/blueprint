import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class IntegrationListTile extends StatelessWidget {
  const IntegrationListTile({
    required this.title,
    required this.subtitle,
    required this.integrationIconUrl,
    required this.onTap,
    super.key,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final String integrationIconUrl;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      dense: false,
      leading: SizedBox(
        width: AppSpacing.xxlg,
        child: Image.network(integrationIconUrl),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({
    required this.title,
    required this.subtitle,
    required this.avatarName,
    required this.onTap,
    super.key,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final String avatarName;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      dense: false,
      leading: SizedBox(
        width: AppSpacing.xxlg,
        child: AvatarIcon(
          text: avatarName,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
    this.trailing,
  });

  factory EventListTile.task({
    required String title,
    required String subtitle,
    required int priorityLevel,
    VoidCallback? onTap,
    Widget? trailing,
  }) =>
      EventListTile(
        leading: EventTypeLabel.task(
          priorityLevel: priorityLevel,
        ),
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
      );

  factory EventListTile.videoConference({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) =>
      EventListTile(
        leading: EventTypeLabel.videoConference(),
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
      );

  factory EventListTile.calendar({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) =>
      EventListTile(
        leading: EventTypeLabel.calendar(),
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
      );

  final EventTypeLabel leading;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.xxxlg + AppSpacing.xs,
      child: ListTile(
        isThreeLine: true,
        dense: false,
        leading: SizedBox(
          width: AppSpacing.xxlg,
          child: leading,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
