import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/blueprint/presentation/pages/blueprint_timeline.dart';
import 'package:blueprint/blueprint/presentation/widgets/blueprint_item_tile.dart';
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart';
import 'package:blueprint/calendar/presentation/widgets/available_time_card.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TodaysBlueprintPage extends StatefulWidget {
  const TodaysBlueprintPage({super.key});

  @override
  State<TodaysBlueprintPage> createState() => _TodaysBlueprintPageState();
}

class _TodaysBlueprintPageState extends State<TodaysBlueprintPage> {
  final MultiSplitViewController _controller = MultiSplitViewController();

  @override
  void initState() {
    super.initState();
    _controller.areas = [
      Area(
        data: 'glance',
        size: 600,
        min: 300,
        builder: (context, area) => const _GlanceView(),
      ),
      Area(
        data: 'timeline',
        flex: 1,
        builder: (context, area) => const BlueprintTimeline(),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: MultiSplitView(
          controller: _controller,
          builder: (BuildContext context, Area area) => area.builder!(
            context,
            area,
          ),
        ),
      ),
    );
  }
}

class _GlanceView extends StatelessWidget {
  const _GlanceView();

  @override
  Widget build(BuildContext context) {
    final currentEvents = context.select(
      (BlueprintBloc bloc) => bloc.state.currentBlueprintItems,
    );
    final nextEvents = context.select(
      (BlueprintBloc bloc) => bloc.state.upcomingBlueprintItems,
    );

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        if (currentEvents.isEmpty && nextEvents.isEmpty)
          const _BlueprintEmpty()
        else ...[
          const _CurrentEvent(),
          if (nextEvents.isNotEmpty) ...[
            const SizedBox(height: 32),
            const _NextOnBlueprint(),
            const _UpcomingEvents(),
          ],
        ],
      ],
    );
  }
}

class _UpcomingEvents extends StatelessWidget {
  const _UpcomingEvents();

  @override
  Widget build(BuildContext context) {
    final nextEvents = context.select(
      (BlueprintBloc bloc) => bloc.state.upcomingBlueprintItems,
    );
    return Column(
      children: [
        ...nextEvents.map(
          (event) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: BlueprintItemTile(
              item: event,
              showSmallVersions: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrentEvent extends StatelessWidget {
  const _CurrentEvent();

  @override
  Widget build(BuildContext context) {
    final currentEvents = context.select(
      (BlueprintBloc bloc) => bloc.state.currentBlueprintItems,
    );

    final nextEvents = context.select(
      (BlueprintBloc bloc) => bloc.state.upcomingBlueprintItems,
    );

    final pastEvents = context.select(
      (BlueprintBloc bloc) => bloc.state.pastBlueprintItems,
    );
    return Column(
      children: [
        if (currentEvents.isNotEmpty) ...[
          const _NowOnBlueprint(),
          ...currentEvents.map(
            (item) => BlueprintItemTile(item: item),
          ),
        ] else ...[
          const _NowOnBlueprint(),
          Builder(
            builder: (context) {
              final nextStartTime = nextEvents.firstOrNull?.startTime;
              final lastEndTime = pastEvents.lastOrNull?.endTime;

              return AvailableTimeCard(
                startTime: lastEndTime ?? DateTime.now(),
                endTime: nextStartTime ??
                    DateTime.now().copyWith(
                      hour: 23,
                      minute: 59,
                    ),
                onScheduleTime: () {
                  context.router.navigate(
                    const CreateBlueprintRoute(),
                  );
                },
              );
            },
          ),
        ],
      ],
    );
  }
}

class _BlueprintEmpty extends StatelessWidget {
  const _BlueprintEmpty();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Icon(
          Icons.calendar_today,
          size: 128,
          color: theme.disabledColor,
        ),
        const SizedBox(height: AppSpacing.xxlg),
        Text(
          l10n.blueprintEmptyTitle,
          style: textTheme.titleLarge,
        ),
        Text(
          l10n.blueprintEmptySubtitle,
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.lg),
        const _CreateBlueprintButton(),
      ],
    );
  }
}

class _NowOnBlueprint extends StatelessWidget {
  const _NowOnBlueprint();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ).copyWith(
        top: 0,
      ),
      child: Row(
        children: [
          Text(
            l10n.currentEventGlanceTitle,
            style: textTheme.titleLarge,
          ),
          const Spacer(),
          const _EditBlueprintButton(),
        ],
      ),
    );
  }
}

class _EditBlueprintButton extends StatelessWidget {
  const _EditBlueprintButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextButton.icon(
      onPressed: () => context.router.navigate(
        const CreateBlueprintRoute(),
      ),
      icon: const Icon(Icons.edit_calendar_rounded),
      label: Text(l10n.editBlueprintCTA),
    );
  }
}

class _CreateBlueprintButton extends StatelessWidget {
  const _CreateBlueprintButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FilledButton.icon(
      onPressed: () {
        context.router.navigate(
          const CreateBlueprintRoute(),
        );
      },
      icon: const Icon(Icons.edit_calendar_rounded),
      label: Text(
        l10n.createTodaysBlueprintCTA,
      ),
    );
  }
}

class _NextOnBlueprint extends StatelessWidget {
  const _NextOnBlueprint();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Text(
            l10n.upcomingEventsTitle,
            style: textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
