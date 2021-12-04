import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:timer_test/main.dart';

void main() {
  (IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding)
      .defaultTestTimeout = const Timeout(Duration(seconds: 45));
  WidgetController.hitTestWarningShouldBeFatal = true;

  // group has no timeout parameter
  group('group of N tests', () {
    // testWidgets('failure caused by defaultTestTimeout',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(const MyApp());

    //   // Tap the '+' icon and trigger a frame.
    //   await tester.tap(find.byIcon(Icons.add));
    //   await tester.pump();
    //   tester.printToConsole('first run before pumpAndSettle');
    //   await tester.pumpAndSettle();
    //   tester.printToConsole('first run after pumpAndSettle');
    // });

    testWidgets(
      'failure caused by timeout of pumpAndSettle',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());

        // Tap the '+' icon and trigger a frame.
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
        tester.printToConsole('first run before pumpAndSettle');
        await tester.pumpAndSettle(const Duration(milliseconds: 100),
            EnginePhase.sendSemanticsUpdate, const Duration(seconds: 15));
        tester.printToConsole('first run after pumpAndSettle');
      },
      timeout: const Timeout(
        Duration(seconds: 20),
      ),
    );

    // testWidgets(
    //   'failure caused by timeout of testWidgets',
    //   (WidgetTester tester) async {
    //     await tester.pumpWidget(const MyApp());

    //     // Tap the '+' icon and trigger a frame.
    //     await tester.tap(find.byIcon(Icons.add));
    //     await tester.pump();
    //     tester.printToConsole('second run before pumpAndSettle');
    //     await tester.pumpAndSettle(
    //         const Duration(milliseconds: 100),
    //         EnginePhase.sendSemanticsUpdate,
    //         const Duration(seconds: 60));
    //     tester.printToConsole('second run after pumpAndSettle');
    //   },
    //   timeout: const Timeout(
    //     Duration(seconds: 20),
    //   ),
    // );

    testWidgets('test using pumpAndSettleWithTimeout',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      tester.printToConsole('third run before pumpAndSettleWithTimeout');
      await tester.pumpAndSettleWithTimeout();
    });
  });
}

extension PumpAndSettleWithTtimeout on WidgetTester {
  Future<int> pumpAndSettleWithTimeout({int timeoutInSeconds = 30}) async {
    return pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, Duration(seconds: timeoutInSeconds));
  }
}
