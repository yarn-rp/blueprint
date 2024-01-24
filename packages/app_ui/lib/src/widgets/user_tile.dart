import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserTile extends StatelessWidget {
  factory UserTile({
    required String displayName,
    String? avatarUrl,
    String? platformUrl,
    Widget? leading,
    double height = 56,
    Key? key,
  }) {
    leading ??= avatarUrl != null
        ? CircleAvatar(
            child: ImageNetwork(
              image: avatarUrl,
              height: 40,
              width: 40,
            ),
          )
        : null;

    return UserTile._(
      platformUrl: platformUrl,
      leading: leading,
      displayName: displayName,
      key: key,
      height: height,
    );
  }

  factory UserTile.customLeading({
    required String displayName,
    required Widget leading,
    double height = 56,
    String? platformUrl,
    Key? key,
  }) {
    return UserTile._(
      platformUrl: platformUrl,
      leading: leading,
      displayName: displayName,
      key: key,
      height: height,
    );
  }

  const UserTile._({
    required this.platformUrl,
    required this.leading,
    required this.displayName,
    required this.height,
    super.key,
  });

  final String? platformUrl;
  final Widget? leading;
  final String displayName;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: platformUrl != null ? () => launchUrlString(platformUrl!) : null,
        leading: leading,
        title: Text(displayName),
      ),
    );
  }
}
