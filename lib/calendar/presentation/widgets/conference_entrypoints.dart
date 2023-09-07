import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferenceEntryPoints extends StatelessWidget {
  const ConferenceEntryPoints({
    required this.conferenceData,
    this.entryPoints = 1,
    super.key,
  });
  final ConferenceData conferenceData;
  final int entryPoints;

  Future<void> _onShare(
    BuildContext context,
    String text,
    String subject,
  ) async {
    // _onShare method:
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...conferenceData.entryPoints.take(entryPoints).map(
              (entryPoint) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Meeting',
                ),
                leading: CircleAvatar(
                  child: Icon(
                    switch (entryPoint.entryPointType) {
                      'video' => Icons.video_call,
                      'phone' => Icons.phone,
                      'sip' => Icons.phone,
                      _ => Icons.video_call,
                    },
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton(
                      onPressed: () => launchUrl(
                        Uri.parse(
                          entryPoint.uri!,
                        ),
                      ),
                      child: const Text(
                        'Join',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Builder(
                      builder: (context) {
                        return IconButton.filled(
                          onPressed: () => _onShare(
                            context,
                            entryPoint.uri!,
                            'Join the meeting with this link',
                          ),
                          icon: Icon(
                            Icons.share,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
