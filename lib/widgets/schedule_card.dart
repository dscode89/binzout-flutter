import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:binzout/widgets/schedule_card_variations/horizontal_schedule_card.dart';
import 'package:binzout/widgets/schedule_card_variations/vertical_schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatefulWidget {
  final BinScheduleEvent scheduleEvent;
  final String orientation;
  final Map<int, Color> binColorReference = const {
    1: Color(0xffB19CD9),
    2: Color(0xffAEC6CF),
    3: Color(0xffADD0B3),
    4: Color(0xff9F8CC3),
    5: Color(0xff9CB2BA),
    6: Color(0xff9BBBA1),
    7: Color(0xff8D7CAD),
    8: Color(0xff8B9EA5),
    9: Color(0xff8AA68F),
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
    final formattedDate = DateFormat().add_E().add_d().add_MMM().add_y().format(
      parsedDate,
    );

    final scheduledDateInMilliseconds = parsedDate.millisecondsSinceEpoch;
    final currentDateInMilliSeconds = DateTime.now().millisecondsSinceEpoch;

    final daysTillDueDate = Duration(
      milliseconds: (scheduledDateInMilliseconds - currentDateInMilliSeconds),
    ).inDays;

    return VerticalScheduleCard(
      widget: widget,
      daysTillDueDate: daysTillDueDate,
      formattedDate: formattedDate,
    );
  }
}
