import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:timer_test/main.dart';

import 'helper/show_test_status.dart';
import 'helper/widget_tester_extension.dart';

void main() {
  (IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding)
      .defaultTestTimeout = const Timeout(Duration(seconds: 15));
  WidgetController.hitTestWarningShouldBeFatal = true;
  WidgetsFlutterBinding.ensureInitialized();

  // group has no timeout parameter
  group('WidgetTester', () {
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

    testWidgets('failure caused by defaultTestTimeout',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final state = tester.state(find.byType(MyHomePage)) as MyHomePageState;
      state.label = tester.testDescription;
      tester.printToConsole('first run before pumpAndSettle');
      await tester.pumpAndSettle();
    });
  });
}
