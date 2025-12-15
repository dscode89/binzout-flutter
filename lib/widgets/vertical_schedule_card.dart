import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:flutter/material.dart';

class VerticalScheduleCard extends StatelessWidget {
  final BinScheduleEvent scheduleEvent;
  final Map<int, MaterialColor> binColorReference = const {
    1: Colors.deepPurple,
    2: Colors.blue,
    3: Colors.green,
  };

  const VerticalScheduleCard({super.key, required this.scheduleEvent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.restore_from_trash,
              color: binColorReference[scheduleEvent.type],
              size: 200,
            ),
          ],
        ),
      ),
    );
  }
}
