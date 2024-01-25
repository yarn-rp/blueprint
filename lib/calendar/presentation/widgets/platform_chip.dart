import 'package:app_ui/app_ui.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/widgets.dart';

class PlatformChip extends LabelChip {
  PlatformChip({
    required Event event,
    super.key,
  }) : super(
          text: event.access.userAccessData.email ??
              event.access.platform!.displayName,
          backgroundColor: null,
          avatar: Image.network(event.access.platform!.iconUrl),
        );
}
