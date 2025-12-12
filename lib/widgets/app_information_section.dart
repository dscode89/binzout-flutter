import 'package:flutter/material.dart';

class AppInformationSection extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isEndDrawerOpen;

  const AppInformationSection({
    super.key,
    required this.scaffoldKey,
    required this.isEndDrawerOpen,
  });

  @override
  State<AppInformationSection> createState() => _AppInformationState();
}

class _AppInformationState extends State<AppInformationSection> {
  bool isHoveringOverDartLink = false;

  void _closeEndDraw() {
    if (widget.isEndDrawerOpen) {
      widget.scaffoldKey.currentState!.closeEndDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why Binzout?',
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 25),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(text: "I created this application for "),
                  TextSpan(
                    text:
                        "two reasons. Myself, my flatmates and my friends all had the same initial problem -",
                  ),
                  TextSpan(
                    text:
                        " we could never remember when the bins were being collected!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "The second reason is that I wanted to practice another language - in this case, ",
                  ),
                  TextSpan(
                    text: "Dart.",
                    style: TextStyle(
                      decoration: isHoveringOverDartLink
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    mouseCursor: SystemMouseCursors.click,
                    onEnter: (e) {
                      setState(() {
                        isHoveringOverDartLink = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHoveringOverDartLink = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "The app is as simple as it gets. Enter a postcode, click 'Search' and the next available dates for your ",
                  ),
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    text: "purple",
                  ),
                  TextSpan(text: ", "),
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    text: "blue",
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    text: "green ",
                  ),
                  TextSpan(text: "bins will be generated for you."),
                ],
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(text: "Enjoy and get ya "),
                  TextSpan(
                    text: "Binzout!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _closeEndDraw,
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
