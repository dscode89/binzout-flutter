import 'dart:js_interop';
import 'package:binzout/classes/bin_schedule_event.dart';
import 'package:binzout/utilities/get_current_postcode.dart';
import 'package:binzout/utilities/type_assert_json_list.dart';
import 'package:binzout/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

class BinSchedulePage extends StatefulWidget {
  const BinSchedulePage({super.key});

  @override
  State<BinSchedulePage> createState() => _BinSchedulePageState();
}

class _BinSchedulePageState extends State<BinSchedulePage> {
  late final List<BinScheduleEvent>? parsedData;
  String initialJson = "";
  bool isLoading = true;
  bool showErrorPage = false;

  @override
  void initState() {
    super.initState();
    _fetchRequestedData();
  }

  Future<void> _fetchRequestedData() async {
    try {
      final providedPostcode = await getCurrentPostcode();
      final url = Uri.parse(
        "https://binzout-server.onrender.com/api/bins/postcode/$providedPostcode",
      );

      final response = await http.get(url);

      if (response.statusCode == 404) {
        throw (response.body);
      }

      final convertedBinScheduleData = typeAssertJsonList(
        response.body,
        BinScheduleEvent.fromJson,
      );

      setState(() {
        parsedData = convertedBinScheduleData;
        initialJson = response.body;
        isLoading = false;
      });
    } catch (e) {
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
          showErrorPage = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double currentScreenWidth = MediaQuery.of(context).size.width.toDouble();

    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fetching your bin schedule...',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    if (showErrorPage) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 140),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'We could not find your data.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Please check your provided postcode.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                  ),
                ),
              ),
              Icon(Icons.error),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(3),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty<Color>.fromMap(<
                    WidgetStatesConstraint,
                    Color
                  >{
                    WidgetState.hovered: const Color.fromARGB(255, 62, 36, 107),
                    WidgetState.any: Theme.of(context).primaryColor,
                  }),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Back To Form',
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 80,
        title: IconButton(
          onPressed: () {
            context.go("/");
          },
          icon: Image.asset('assets/binzout.png', width: 250),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
      ),
      body: currentScreenWidth < 1340
          ? SizedBox(
              width: double.infinity,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          color: Theme.of(context).primaryColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            for (var item in parsedData!)
                              ScheduleCard(
                                scheduleEvent: item,
                                orientation: 'vertical',
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1300, maxHeight: 410),
                child: Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var item in parsedData!)
                          ScheduleCard(
                            scheduleEvent: item,
                            orientation: 'vertical',
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add to calendar",
        onPressed: () async {
          try {
            final url = Uri.parse(
              'http://localhost:8080/api/generateCalendarEvents',
            );
            final today = DateTime.now();
            String todaysDateString =
                '${today.day}-${today.month}-${today.year}';

            final calendarEvents = await http.post(url, body: initialJson);
            final jsBytes = calendarEvents.bodyBytes;

            final parts = JSArray() as JSArray<web.BlobPart>;
            parts.add(jsBytes.toJS);

            final fileBlob = web.Blob(
              parts,
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
          } catch (e) {
            print('${e}');
          }
        },
        child: Icon(Icons.calendar_month),
      ),
    );
  }
}
