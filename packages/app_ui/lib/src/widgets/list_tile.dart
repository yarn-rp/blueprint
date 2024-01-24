import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

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
        child: Image.network(
          integrationIconUrl,
        ),
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
    this.isMini = false,
    this.onTap,
    super.key,
    this.trailing,
    this.textColor,
  });

  factory EventListTile.task({
    required String title,
    required String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? textColor,
  }) =>
      EventListTile(
        leading: EventTypeLabel.task(),
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
        textColor: textColor,
      );

  factory EventListTile.videoConference({
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? textColor,
  }) =>
      EventListTile(
        leading: EventTypeLabel.videoConference(),
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
        textColor: textColor,
      );

  factory EventListTile.calendar({
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? textColor,
  }) =>
      EventListTile(
        leading: EventTypeLabel.calendar(),
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        trailing: trailing,
        textColor: textColor,
      );

  final EventTypeLabel leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isMini;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (isMini) {
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor,
                    ),
              ),
            ),
            if (subtitle != null) ...[
              const Spacer(),
              Flexible(
                flex: 4,
                child: Text(
                  subtitle!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor,
                      ),
                ),
              ),
            ]
          ],
        ),
      );
    }
    return SizedBox(
      height: AppSpacing.xxxlg + AppSpacing.xs,
      child: ListTile(
        isThreeLine: subtitle != null,
        dense: false,
        leading: SizedBox(
          width: AppSpacing.xxlg,
          child: leading,
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor,
              ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: textColor,
                    ),
              ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
