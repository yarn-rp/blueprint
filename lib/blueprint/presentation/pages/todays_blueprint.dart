import 'package:auto_route/auto_route.dart';
import 'package:blueprint/blueprint/entities/calendar_event.dart';
import 'package:blueprint/blueprint/presentation/pages/today_time_line.dart';
import 'package:blueprint/blueprint/presentation/widgets/calendar_event_tile.dart';
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:blueprint/settings/presentation/pages/working_time_page.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet<GeneralCalendarEvent?>(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: context.read<TodaysBlueprintCubit>(),
              child: const AddEventBottomSheet(),
            );
          },
        ).then((value) {
          if (value != null) {
            context.read<TodaysBlueprintCubit>().addNewCalendarEvent(value);
          }
        }),
        label: const Text('Add Event'),
        icon: const Icon(Icons.add),
      ),
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

class AddEventBottomSheet extends StatefulWidget {
  const AddEventBottomSheet({super.key});

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  String? subject;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    startTime = TimeOfDay.now();

    endTime = TimeOfDay.now().replacing(hour: startTime.hour + 1);
    super.initState();
  }

  void validate() {
    if (formKey.currentState!.validate()) {
      final event = GeneralCalendarEvent(
        subject: subject!,
        startTime: DateTime.now().copyWith(
          hour: startTime.hour,
          minute: startTime.minute,
        ),
        endTime: DateTime.now().copyWith(
          hour: endTime.hour,
          minute: endTime.minute,
        ),
      );
      context.router.pop(
        event,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: validate,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Add New Event'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            // Title Text Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                onChanged: (value) {
                  subject = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            // Start Time Text Field
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('From'),
                      //Time of day picker
                      TimeInput(
                        onChanged: (time) {
                          startTime = time;
                        },
                        initialTime: startTime,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('To'),
                      //Time of day picker
                      TimeInput(
                        onChanged: (time) {
                          endTime = time;
                        },
                        initialTime: endTime,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
