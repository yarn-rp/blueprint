import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poll_e_task/blueprint/presentation/pages/today_time_line.dart';
import 'package:poll_e_task/blueprint/presentation/widgets/calendar_event_tile.dart';
import 'package:poll_e_task/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';

class TodaysBlueprint extends StatelessWidget {
  const TodaysBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 600;
    final isWide = MediaQuery.of(context).size.width > 1200;
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                              //Button to add entry
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: const [
                                    BulletPoint(
                                      text:
                                          'Implement models for the app and the API',
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    BulletPoint(
                                      text: 'Add unit test for the models',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (nextEvents?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 32),
                      Text(
                        'Next on Blueprint',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      if (nextEvents?.isNotEmpty ?? false)
                        ...nextEvents!.map(
                          (event) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CalendarEventTile(event: event),
                          ),
                        )
                    ],
                    if (!isWide)
                      const SizedBox(
                        height: 2480,
                        child: TodayTimeline(),
                      )
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

class BulletPoint extends StatelessWidget {
  const BulletPoint({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 8),
          child: Icon(
            Icons.fiber_manual_record,
            size: 12,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 2),
              Text(
                '${DateFormat('hh:mm a').format(DateTime.now())} - '
                '${DateFormat('hh:mm a').format(DateTime.now())}',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
