import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Create a key for the navigator, so our tests can control dialogs
  GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Timer? _timer;
  var label = 'TimeoutTester';

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        _counter++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline1,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
