import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:binzout/utilities/type_assert_json_list.dart';

import 'package:binzout/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class BinSchedulePage extends StatefulWidget {
  final String postcode;

  const BinSchedulePage({super.key, required this.postcode});

  @override
  State<BinSchedulePage> createState() => _BinSchedulePageState();
}

class _BinSchedulePageState extends State<BinSchedulePage> {
  late final List<BinScheduleEvent>? testData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTestJson();
  }

  Future<void> _loadTestJson() async {
    final testJson = await rootBundle.loadString('assets/testData.json');
    final convertedBinScheduleData = typeAssertJsonList(
      testJson,
      BinScheduleEvent.fromJson,
    );

    setState(() {
      testData = convertedBinScheduleData;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentScreenWidth = MediaQuery.of(context).size.width.toDouble();
    print(currentScreenWidth);

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Upcoming collection dates:',
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
      ),
      body: currentScreenWidth > 1244.0
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1300, maxHeight: 600),
                child: Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.white),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (var item in testData!)
                        ScheduleCard(
                          scheduleEvent: item,
                          orientation: 'vertical',
                        ),
                    ],
                  ),
                ),
              ),
            )
          : currentScreenWidth < 702
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),

                child: Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.white),
                  ),
                  child: ListView(
                    children: [
                      for (var item in testData!)
                        ScheduleCard(
                          scheduleEvent: item,
                          orientation: 'vertical',
                        ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),

                child: Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.white),
                  ),
                  child: ListView(
                    children: [
                      Text('gay'),
                      for (var item in testData!)
                        ScheduleCard(
                          scheduleEvent: item,
                          orientation: 'horizontal',
                        ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add to calendar",
        onPressed: () {},
        child: Icon(Icons.calendar_month),
      ),
    );
  }
}
