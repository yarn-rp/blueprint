import 'package:blueprint/settings/entities/working_calendar.dart';
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkingTime extends StatefulWidget {
  const WorkingTime({super.key});

  @override
  State<WorkingTime> createState() => _WorkingTimeState();
}

class _WorkingTimeState extends State<WorkingTime> {
  late DaysOfWeek selectedWeekDay;

  @override
  void initState() {
    selectedWeekDay = DaysOfWeek.values[DateTime.now().weekday - 1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, WorkingCalendar>(
      selector: (state) => state.workingCalendar,
      builder: (context, workingCalendar) {
        return ExpansionTile(
          leading: const Icon(Icons.access_time),
          title: const Text(
            'Working hours',
          ),
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: workingCalendar.events.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
                itemBuilder: (context, index) {
                  final day = workingCalendar.events.keys.elementAt(index);

                  return ChoiceChip(
                    onSelected: (selected) {
                      setState(() {
                        if (selectedWeekDay != day) {
                          selectedWeekDay = day;
                        }
                      });
                    },
                    label: Text(day.name),
                    selected: selectedWeekDay == day,
                  );
                },
              ),
            ),
            ScheduledTimeTile(
              workTime: workingCalendar.events[selectedWeekDay]!.firstOrNull,
              day: selectedWeekDay,
            )
          ],
        );
      },
    );
  }

  /// Refers to the minimum duration you can move in the timeline.
  final dragUnit = 5;
}

class ScheduledTimeTile extends StatelessWidget {
  const ScheduledTimeTile({required this.day, super.key, this.workTime});
  final WorkTime? workTime;
  final DaysOfWeek day;
  @override
  Widget build(BuildContext context) {
    if (workTime == null) {
      return ListTile(
        onTap: () async {
          final bloc = context.read<SettingsBloc>();
          final edited = await editWorkTime(context, workTime);

          if (edited != null) {
            bloc.add(
              SettingsEvent.changeWorkingHours(
                day,
                [edited],
              ),
            );
          }
        },
        title: const Text(
          'No Scheduled Time',
        ),
        subtitle: const Text(
          'Tap to add',
        ),
      );
    }
    return ListTile(
      title: const Text('Scheduled Work Time'),
      onTap: () async {
        final bloc = context.read<SettingsBloc>();
        final edited = await editWorkTime(context, workTime);

        if (edited != null) {
          bloc.add(
            SettingsEvent.changeWorkingHours(
              day,
              [edited],
            ),
          );
        }
      },
      subtitle: Text(
        'From ${workTime!.start.format(context)} to '
        '${workTime!.end.format(context)}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => editWorkTime(context, workTime!),
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<SettingsBloc>().add(
                    SettingsEvent.changeWorkingHours(
                      day,
                      [],
                    ),
                  );
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}

Future<WorkTime?> editWorkTime(BuildContext context, WorkTime? workTime) {
  return showModalBottomSheet<WorkTime>(
    context: context,
    builder: (context) {
      return ModifyWorkTimeBody(
        workTime: workTime ?? WorkTime.from9To5(),
      );
    },
  );
}

class ModifyWorkTimeBody extends StatefulWidget {
  const ModifyWorkTimeBody({
    required this.workTime,
    super.key,
  });
  final WorkTime workTime;

  @override
  State<ModifyWorkTimeBody> createState() => _ModifyWorkTimeBodyState();
}

class _ModifyWorkTimeBodyState extends State<ModifyWorkTimeBody> {
  late WorkTime workTime;

  @override
  void initState() {
    workTime = widget.workTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Work Time'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(
            workTime,
          );
        },
        child: const Icon(
          Icons.check,
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('From'),
                //Time of day picker
                TimeInput(
                  onChanged: (time) {
                    setState(() => workTime = workTime.copyWith(start: time));
                  },
                  initialTime: workTime.start,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text('To'),
                TimeInput(
                  onChanged: (time) {
                    setState(() => workTime = workTime.copyWith(end: time));
                  },
                  initialTime: workTime.end,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeInput extends StatefulWidget {
  const TimeInput({
    required this.onChanged,
    required this.initialTime,
    super.key,
  });
  final void Function(TimeOfDay time) onChanged;
  final TimeOfDay initialTime;

  @override
  _TimeInputState createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay _selectedTime;
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _hourController.text = _selectedTime.hour.toString();
    _minuteController.text = _selectedTime.minute.toString();

    _hourController.addListener(updateSelectedTime);
    _minuteController.addListener(updateSelectedTime);
  }

  void updateSelectedTime() {
    final hour = int.tryParse(_hourController.text);
    final minute = int.tryParse(_minuteController.text);

    widget.onChanged(TimeOfDay(hour: hour ?? 0, minute: minute ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _hourController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Hour',
                    hintText: '00',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid hour';
                    }
                    final intHour = int.tryParse(value);
                    if (intHour == null || intHour < 0 || intHour > 23) {
                      return 'Please enter a valid hour between 0 and 23';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _minuteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Minute',
                    hintText: '00',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid minute';
                    }
                    final intMinute = int.tryParse(value);
                    if (intMinute == null || intMinute < 0 || intMinute > 59) {
                      return 'Please enter a valid minute between 0 and 59';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
