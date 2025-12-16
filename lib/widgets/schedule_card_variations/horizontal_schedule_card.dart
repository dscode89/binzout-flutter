import 'package:binzout/widgets/schedule_card.dart';
import 'package:flutter/material.dart';

class HorizontalScheduleCard extends StatelessWidget {
  final ScheduleCard widget;
  final int daysTillDueDate;
  final String formattedDate;

  const HorizontalScheduleCard({
    super.key,
    required this.widget,
    required this.formattedDate,
    required this.daysTillDueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.restore_from_trash,
              color: widget!.binColorReference[widget.scheduleEvent.type],
              size: 200,
            ),
            Column(
              children: [
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
          ],
        ),
      ),
    );
  }
}
