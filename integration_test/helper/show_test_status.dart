import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timer_test/main.dart';

import 'widget_tester_extension.dart';

Future<void> showTestStatus(WidgetTester tester, TestStatus status) async {
  MyAppState appState = tester.state(find.byType(MyApp));
  NavigatorState navigator = appState.navKey.currentState!;
  final statusString =
      status == TestStatus.started ? 'Test started...' : 'Test succeeded!';
  showDialog(
    context: navigator.context,
    builder: (c) => _SomeDialog(
        title: statusString, status: status, name: tester.testDescription),
  );
  await tester.pumpNtimes(times: 100);
  navigator.pop();
  await tester.pumpNtimes(times: 10);
}

enum TestStatus {
  started,
  success,
  failure,
}

class _SomeDialog extends StatelessWidget {
  final Map<TestStatus, Color> colorForStatus = const {
    TestStatus.started: Colors.white,
    TestStatus.success: Colors.lightGreen,
    TestStatus.failure: Colors.red,
  };
  final String name;
  final String title;
  final TestStatus status;
  const _SomeDialog({
    Key? key,
    required this.name,
    required this.status,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(name),
      backgroundColor: colorForStatus[status],
      // actions: [
      //   OutlinedButton(
      //     key: const ValueKey("okBtn"),
      //     onPressed: () => Navigator.pop(context),
      //     child: const Text("Ok"),
      //   ),
      // ],
    );
  }
}
