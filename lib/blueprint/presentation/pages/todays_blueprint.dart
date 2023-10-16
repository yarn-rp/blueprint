import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:blueprint/blueprint/presentation/pages/today_time_line.dart';
import 'package:blueprint/blueprint/presentation/widgets/calendar_event_tile.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TodaysBlueprintPage extends StatelessWidget {
  const TodaysBlueprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final isPhone = MediaQuery.of(context).size.width < 600;
    final isWide = MediaQuery.of(context).size.width >= 1150;
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 4,
            child: BlocBuilder<TodaysBlueprintCubit, TodaysBlueprintState>(
              builder: (context, state) {
                final currentEvent = state.currentEvent;
                final nextEvents = state.nextEvents;
                return ListView(
                  padding: const EdgeInsetsDirectional.all(16),
                  children: [
                    if (currentEvent != null) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Now on Blueprint',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CalendarEventTile(event: currentEvent),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (nextEvents?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 32),
                      NextOnBlueprint(nextEvents: nextEvents),
                    ],
                    if (!isWide)
                      const SizedBox(
                        height: 2480,
                        child: TodayTimeline(),
                      ),
                  ],
                );
              },
            ),
          ),
          if (isWide)
            const Flexible(
              flex: 3,
              child: TodayTimeline(),
            ),
        ],
      ),
    );
  }
}

class NextOnBlueprint extends StatelessWidget {
  const NextOnBlueprint({
    required this.nextEvents,
    super.key,
  });

  final Iterable<CalendarEvent>? nextEvents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Text(
            'Upcoming events',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 16),
        if (nextEvents?.isNotEmpty ?? false)
          ...nextEvents!.take(min(2, nextEvents!.length)).map(
                (event) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: CalendarEventTile(
                    event: event,
                    showSmallVersions: true,
                  ),
                ),
              ),
      ],
    );
  }
}
