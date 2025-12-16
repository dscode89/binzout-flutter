import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:binzout/widgets/schedule_card_variations/horizontal_schedule_card.dart';
import 'package:binzout/widgets/schedule_card_variations/vertical_schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatefulWidget {
  final BinScheduleEvent scheduleEvent;
  final String orientation;
  final Map<int, MaterialColor> binColorReference = const {
    1: Colors.deepPurple,
    2: Colors.blue,
    3: Colors.green,
  };

  const ScheduleCard({
    super.key,
    required this.scheduleEvent,
    required this.orientation,
  });

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

    return widget.orientation == "vertical"
        ? VerticalScheduleCard(
            widget: widget,
            daysTillDueDate: daysTillDueDate,
            formattedDate: formattedDate,
          )
        : HorizontalScheduleCard(
            widget: widget,
            daysTillDueDate: daysTillDueDate,
            formattedDate: formattedDate,
          );
  }
}
