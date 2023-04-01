import 'package:flutter/material.dart';
import 'package:poll_e_task/tasks/entities/entities.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => launchUrlString(user.platformUrl),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
      title: Text(user.displayName),
    );
  }
}
