import 'package:binzout/widgets/schedule_card.dart';
import 'package:flutter/material.dart';

class VerticalScheduleCard extends StatelessWidget {
  final ScheduleCard widget;
  final int daysTillDueDate;
  final String formattedDate;

  const VerticalScheduleCard({
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
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromARGB(255, 243, 242, 243),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              Icons.restore_from_trash,
              color: widget!.binColorReference[widget.scheduleEvent.type],
              size: 150,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    daysTillDueDate == 0
                        ? 'Put your bin out tonight!'
                        : '$daysTillDueDate days till bin collection.',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 245, 212, 223),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
