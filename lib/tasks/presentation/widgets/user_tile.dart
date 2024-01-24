import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.platformUrl,
    required this.avatarUrl,
    required this.displayName,
    required this.email,
    super.key,
  });
  final String? platformUrl;
  final String? avatarUrl;
  final String? displayName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => platformUrl != null ? launchUrlString(platformUrl!) : null,
      leading: avatarUrl != null
          ? CircleAvatar(
              child: ImageNetwork(
                image: avatarUrl!,
                height: 40,
                width: 40,
              ),
            )
          : null,
      title: displayName != null ? Text(displayName!) : Text(email ?? ''),
    );
  }
}
