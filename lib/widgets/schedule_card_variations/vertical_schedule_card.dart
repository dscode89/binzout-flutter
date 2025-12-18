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
    String titleText = switch (widget.scheduleEvent.type + 3) {
      4 => 'Purple Bin',
      5 => 'Blue Bin',
      6 => 'Green Bin',
      _ => 'Unknown Bin',
    };

    String subTitleText = switch (widget.scheduleEvent.type + 3) {
      4 => 'This bin is for general waste.',
      5 => 'This bin is for recycling. ',
      6 => 'This bin is for your green waste. ',
      _ => 'Unknown Waste',
    };

    return SizedBox(
      width: 350,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: widget
                            .binColorReference[widget.scheduleEvent.type + 3],
                      ),
                    ),
                    Text(
                      subTitleText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: widget
                            .binColorReference[widget.scheduleEvent.type + 6],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.binColorReference[widget.scheduleEvent.type],
              ),
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: Icon(
                  Icons.restore_from_trash,
                  size: 150,
                  color:
                      widget.binColorReference[widget.scheduleEvent.type + 3],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Collection Date: $formattedDate',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Message: ${daysTillDueDate + 1} days till your bin collection.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
