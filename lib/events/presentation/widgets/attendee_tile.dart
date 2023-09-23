import 'package:event_repository/event_repository.dart';
import 'package:flutter/material.dart';

class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    required this.attendantStatus,
    required this.email,
    this.platformUrl,
    this.displayName,
    super.key,
  });
  final String? platformUrl;
  final AttendantStatus attendantStatus;
  final String? displayName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return switch (attendantStatus) {
              AttendantStatus.accepted => const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
              AttendantStatus.declined => const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 20,
                ),
              AttendantStatus.tentative => const Icon(
                  Icons.help,
                  color: Colors.orange,
                  size: 20,
                ),
              AttendantStatus.needsAction => const Icon(
                  Icons.help,
                  color: Colors.grey,
                  size: 20,
                ),
              AttendantStatus.none => const Icon(
                  Icons.help,
                  color: Colors.grey,
                  size: 20,
                ),
            };
          },
        ),
        const SizedBox(
          width: 8,
        ),
        if (displayName != null) Text(displayName!) else Text(email ?? ''),
      ],
    );
  }
}
