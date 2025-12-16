import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatefulWidget {
  final BinScheduleEvent scheduleEvent;
  final Map<int, MaterialColor> binColorReference = const {
    1: Colors.deepPurple,
    2: Colors.blue,
    3: Colors.green,
  };

  const ScheduleCard({super.key, required this.scheduleEvent});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(widget.scheduleEvent.date);
    final formattedDate = DateFormat().add_E().add_yMd().format(parsedDate);

    final scheduledDateInMilliseconds = parsedDate.millisecondsSinceEpoch;
    final currentDateInMilliSeconds = DateTime.now().millisecondsSinceEpoch;

    final daysTillDueDate = Duration(
      milliseconds: (scheduledDateInMilliseconds - currentDateInMilliSeconds),
    ).inDays;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.restore_from_trash,
              color: widget.binColorReference[widget.scheduleEvent.type],
              size: 200,
            ),
            Text(
              'Next Collection Date:',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              formattedDate,
              style: TextStyle(fontSize: 15, color: Colors.pink),
            ),
            SizedBox(height: 40),
            Text(
              daysTillDueDate == 0
                  ? 'Put your bin out tonight!'
                  : '$daysTillDueDate days till bin collection.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
