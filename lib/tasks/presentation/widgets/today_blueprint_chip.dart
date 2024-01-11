import 'package:app_ui/app_ui.dart';

class TodaysBlueprintChip extends LabelChip {
  const TodaysBlueprintChip({
    super.key,
  }) : super(
          text: 'Today\'s Blueprint',
          avatar: const BlueprintIcon(
            height: 40,
            width: 40,
          ),
        );
}
