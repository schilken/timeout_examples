import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:timer_test/main.dart';

void main() {
  (IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding)
      .defaultTestTimeout = const Timeout(Duration(seconds: 15));
  WidgetController.hitTestWarningShouldBeFatal = true;
  WidgetsFlutterBinding.ensureInitialized();

  // group has no timeout parameter
  group('group of N tests', () {
    testWidgets(
      'failure caused by timeout of pumpAndSettle',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        await showTestStatus(tester, 'test started');

        final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
        state.label = tester.testDescription;
        tester.printToConsole(tester.testDescription);
        await tester.pumpAndSettle(const Duration(milliseconds: 100),
            EnginePhase.sendSemanticsUpdate, const Duration(seconds: 5));
      },
      timeout: const Timeout(
        Duration(seconds: 20),
      ),
    );

    testWidgets('test using pumpAndSettleWithTimeout',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await showTestStatus(tester, 'test started');

      final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
      state.label = tester.testDescription;
      tester.printToConsole(tester.testDescription);
      await tester.pumpAndSettleWithTimeout(seconds: 3);
    });

    testWidgets('show a dialog', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Check internal state
      final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
      state.label = tester.testDescription;
      tester.printToConsole(tester.testDescription);
      await tester.pump();

      // tester.printToConsole("All states: ");
      // tester.allStates.forEach((s) => print(s));
//      tester.printToConsole(navigator.context.toString());
      await showTestStatus(tester, 'test started');
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await showTestStatus(tester, 'test success!');

      // Verify dialog was closed
//      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
      'failure caused by timeout of testWidgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        await showTestStatus(tester, 'test started');

        final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
        state.label = tester.testDescription;
        tester.printToConsole(tester.testDescription);
        await tester.pumpAndSettle();
      },
      timeout: const Timeout(
        Duration(seconds: 10),
      ),
    );

    // testWidgets('failure caused by defaultTestTimeout',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(const MyApp());

    //   final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
    //   state.label = tester.testDescription;
    //   tester.printToConsole('first run before pumpAndSettle');
    //   await tester.pumpAndSettle();
    // });
  });
}

Future<void> showTestStatus(WidgetTester tester, String status) async {
  MyAppState appState = tester.state(find.byType(MyApp));
  NavigatorState navigator = appState.navKey.currentState!;

  showDialog(
    context: navigator.context,
    builder: (c) => _SomeDialog(title: status, content: tester.testDescription),
  );
  await tester.pumpNtimes(times: 200);
  navigator.pop();
  await tester.pumpNtimes(times: 10);
}

extension PumpAndSettleWithTtimeout on WidgetTester {
  Future<int> pumpAndSettleWithTimeout({int seconds = 30}) async {
    return pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, Duration(seconds: seconds));
  }

  Future<void> pumpNtimes({int times = 3}) async {
    return await Future.forEach(
        Iterable.generate(times), (_) async => await pump());
  }
}

class _SomeDialog extends StatelessWidget {
  final String title;
  final String content;
  const _SomeDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
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
