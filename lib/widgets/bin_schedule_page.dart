import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:binzout/utilities/type_assert_json_list.dart';
import 'package:binzout/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

class BinSchedulePage extends StatefulWidget {
  final String postcode;
  const BinSchedulePage({super.key, required this.postcode});

  @override
  State<BinSchedulePage> createState() => _BinSchedulePageState();
}

class _BinSchedulePageState extends State<BinSchedulePage> {
  late final List<BinScheduleEvent>? testData;
  String initialJson = "";

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
      initialJson = testJson;
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),

                  child: Container(
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(6),
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
        onPressed: () async {
          final url = Uri.parse(
            'http://localhost:8080/api/generateCalendarEvents',
          );
          final today = DateTime.now();
          String todaysDateString = '${today.day}-${today.month}-${today.year}';

          final calendarEvents = await http.post(url, body: initialJson);
          final bytes = calendarEvents.bodyBytes.toJS;

          final fileBlob = web.Blob(
            [bytes].toJS,
            web.BlobPropertyBag(type: 'text/calendar;charset=utf-8'),
          );

          final objectUrl = web.URL.createObjectURL(fileBlob);

          final anchor = web.HTMLAnchorElement()
            ..href = objectUrl
            ..download = '$todaysDateString-bins.ics'
            ..style.display = 'none';

          web.document.body!.append(anchor);
          anchor.click();
          anchor.remove();

          web.URL.revokeObjectURL(objectUrl);
        },
        child: Icon(Icons.calendar_month),
      ),
    );
  }
}
