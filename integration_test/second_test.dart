import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:timeout_examples/main.dart';
import 'helper/show_test_status.dart';

void main() {
  (IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding)
      .defaultTestTimeout = const Timeout(Duration(seconds: 15));
  WidgetController.hitTestWarningShouldBeFatal = true;
  WidgetsFlutterBinding.ensureInitialized();

  // group has no timeout parameter
  group('widgetTester', () {
    testWidgets(
      'fails after timeout given by parameter - second_test',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        tester.printToConsole(tester.testDescription);
        await showTestStatus(tester, TestStatus.started);
        await tester.pumpAndSettle();
      },
      timeout: const Timeout(
        Duration(seconds: 10),
      ),
    );

    testWidgets(
        'fails after IntegrationTestWidgetsFlutterBinding.defaultTestTimeout - second_test',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      tester.printToConsole('first run before pumpAndSettle');
      await showTestStatus(tester, TestStatus.started);
      await tester.pumpAndSettle();
    });
  });
}
