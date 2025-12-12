import 'package:binzout/widgets/app_information_section.dart';
import 'package:binzout/widgets/postcode_search_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binzout Flutter App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isEndDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'BinZout.',
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
      ),
      endDrawer: AppInformationSection(
        scaffoldKey: _scaffoldKey,
        isEndDrawerOpen: isEndDrawerOpen,
      ),
      onEndDrawerChanged: (hasChanged) {
        setState(() {
          isEndDrawerOpen = !isEndDrawerOpen;
        });
      },
      endDrawerEnableOpenDragGesture: false,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [PostcodeSearchForm()],
        ),
      ),
    );
  }
}
