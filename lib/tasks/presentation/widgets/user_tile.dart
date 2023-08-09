import 'package:flutter/material.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserTile extends StatelessWidget {
  const UserTile({required this.user, super.key});
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
