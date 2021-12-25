import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:timeout_examples/main.dart';
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
      'fails after timeout given as parameter to pumpAndSettle',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        tester.printToConsole(tester.testDescription);
        await tester.pumpAndSettle(const Duration(milliseconds: 100),
            EnginePhase.sendSemanticsUpdate, const Duration(seconds: 5));
      },
      timeout: const Timeout(
        Duration(seconds: 20),
      ),
    );

    testWidgets('using pumpAndSettleWithTimeout fails with timeout',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      tester.printToConsole(tester.testDescription);
      await tester.pumpAndSettleWithTimeout(seconds: 3);
    });

    group('testWidgets', () {
      testWidgets(
        'fails after timeout given by parameter',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MyApp());
          tester.printToConsole(tester.testDescription);
          await tester.pumpAndSettle();
        },
        timeout: const Timeout(
          Duration(seconds: 10),
        ),
      );

      // this test is not executed because of timeout of testWidgets failure of the preceeding test
      testWidgets(
          'fails after IntegrationTestWidgetsFlutterBinding.defaultTestTimeout ',
          (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());
        tester.printToConsole(tester.testDescription);
        await tester.pumpAndSettle();
      });
    });
  });
}
