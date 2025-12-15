import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScheduleCard extends StatelessWidget {
  final BinScheduleEvent scheduleData;
  final Map<int, MaterialColor> binColorReference = const {
    1: Colors.deepPurple,
    2: Colors.blue,
    3: Colors.green,
  };

  const ScheduleCard({super.key, required this.scheduleData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.restore_from_trash,
          color: binColorReference[scheduleData.type],
          size: 130,
        ),
      ],
    );
  }
}
