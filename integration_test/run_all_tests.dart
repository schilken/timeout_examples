import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:timer_test/main.dart';

void main() {
  (IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding)
      .defaultTestTimeout = const Timeout(Duration(seconds: 15));
  WidgetController.hitTestWarningShouldBeFatal = true;

  // group has no timeout parameter
  group('group of N tests', () {
    testWidgets(
      'failure caused by timeout of pumpAndSettle',
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

    testWidgets('test using pumpAndSettleWithTimeout',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      tester.printToConsole(tester.testDescription);
      await tester.pumpAndSettleWithTimeout(seconds: 7);
    });

    testWidgets(
      'failure caused by timeout of testWidgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());

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

    //   tester.printToConsole('first run before pumpAndSettle');
    //   await tester.pumpAndSettle();
    // });
  });
}

extension PumpAndSettleWithTtimeout on WidgetTester {
  Future<int> pumpAndSettleWithTimeout({int seconds = 30}) async {
    return pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, Duration(seconds: seconds));
  }
}
