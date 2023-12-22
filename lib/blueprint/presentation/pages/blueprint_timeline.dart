import 'package:app_ui/app_ui.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlueprintTimeline extends StatefulWidget {
  const BlueprintTimeline({super.key});

  @override
  State<BlueprintTimeline> createState() => _BlueprintTimelineState();
}

class _BlueprintTimelineState extends State<BlueprintTimeline> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: screenHeight < 800
                ? Scrollbar(
                    // Scrollbar needs a scroll controller in order to
                    // ensure visibility
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ListView(
                      controller: _scrollController,
                      children: const <Widget>[
                        SizedBox(
                          height: 600,
                          child: _Timeline(),
                        ),
                      ],
                    ),
                  )
                : const _Timeline(),
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodaysBlueprintCubit, TodaysBlueprintState>(
      builder: (context, state) {
        return TodayTimeline(
          events: state.calendarEvents.map((e) {
            return (
              subject: e.subject,
              startTime: e.startTime,
              endTime: e.endTime,
              color: HexColor.fromHex(e.color),
              typeLabel: e.map(
                event: (event) => event.event.conferenceData != null
                    ? EventTypeLabel.videoConference()
                    : EventTypeLabel.calendar(),
                task: (task) => EventTypeLabel.calendar(),
              ),
            );
          }).toList(),
          onEventUpdate: (event, startDate, endDate) {},
        );
      },
    );
  }
}
