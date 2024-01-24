import 'package:blueprint/core/l10n/l10n.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        ...conferenceData.entryPoints.take(entryPoints).map(
              (entryPoint) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  l10n.videoConferenceLabel,
                  style: textTheme.bodyMedium,
                ),
                subtitle: SelectableText(
                  entryPoint.uri!,
                  style: textTheme.bodySmall,
                ),
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.tertiary,
                  child: Icon(
                    switch (entryPoint.entryPointType) {
                      'video' => Icons.video_call_outlined,
                      'phone' => Icons.phone_outlined,
                      'sip' => Icons.phone,
                      _ => Icons.video_call_outlined,
                    },
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton.tonal(
                      style:
                          Theme.of(context).filledButtonTheme.style?.copyWith(
                                backgroundColor: MaterialStateProperty.all(
                                  theme.colorScheme.tertiaryContainer,
                                ),
                              ),
                      onPressed: () => launchUrl(
                        Uri.parse(
                          entryPoint.uri!,
                        ),
                      ),
                      child: Text(
                        l10n.joinNowCTA,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton.filledTonal(
                      style: Theme.of(context).iconButtonTheme.style?.copyWith(
                            backgroundColor: MaterialStateProperty.all(
                              theme.colorScheme.tertiaryContainer,
                            ),
                          ),
                      color: theme.colorScheme.tertiary,
                      onPressed: () => _onShare(
                        context,
                        entryPoint.uri!,
                        l10n.shareVideoConferenceLinkMessage,
                      ),
                      icon: const Icon(Icons.share_outlined),
                    )
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
