import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:timeout_examples/main.dart';

import 'helper/show_test_status.dart';
import 'helper/widget_tester_extension.dart';

void main() {
  (IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding)
      .defaultTestTimeout = const Timeout(Duration(seconds: 15));
  WidgetController.hitTestWarningShouldBeFatal = true;
  WidgetsFlutterBinding.ensureInitialized();

  // group has no timeout parameter
  group('pumpAndSettle', () {
    testWidgets(
      'failure caused by timeout',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        await showTestStatus(tester, TestStatus.started);

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

    testWidgets('using pumpAndSettleWithTimeout', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await showTestStatus(tester, TestStatus.started);

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
      await showTestStatus(tester, TestStatus.started);
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await showTestStatus(tester, TestStatus.success);

      // Verify dialog was closed
//      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
      'failure caused by timeout of testWidgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        await showTestStatus(tester, TestStatus.started);

        final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
        state.label = tester.testDescription;
        tester.printToConsole(tester.testDescription);
        await tester.pumpAndSettle();
      },
      timeout: const Timeout(
        Duration(seconds: 10),
      ),
    );

    // this test is not executed because of timeout of testWidgets failure of the preceeding test
    testWidgets('failure caused by defaultTestTimeout',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await showTestStatus(tester, TestStatus.started);

      final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
      state.label = tester.testDescription;
      tester.printToConsole(tester.testDescription);
      await tester.pumpAndSettle();
    });
  });
}
