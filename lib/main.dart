import 'package:binzout/widgets/app_information_section.dart';
import 'package:binzout/widgets/bin_schedule_page.dart';
import 'package:binzout/widgets/postcode_search_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'Binzout!');
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'results',
          builder: (BuildContext context, GoRouterState state) {
            return const BinSchedulePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Binzout!",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset('assets/binzout.png', width: 250),
        toolbarHeight: 80,
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
