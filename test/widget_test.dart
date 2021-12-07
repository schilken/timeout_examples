import 'package:flutter_test/flutter_test.dart';
import 'package:timeout_examples/main.dart';

void main() {
  testWidgets('Endless counter with defaultTimeout',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.printToConsole('before pumpAndSettle ${tester.testDescription}');
    await tester.pumpAndSettle();
  });

  testWidgets('Endless counter with 10 minutes timeout',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.printToConsole('before pumpAndSettle ${tester.testDescription}');
    await tester.pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, const Duration(minutes: 10));
  });

  testWidgets('Endless counter with 1 minute timeout and duration 100ms',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.printToConsole('before pumpAndSettle ${tester.testDescription}');
    await tester.pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, const Duration(minutes: 1));
  });

  testWidgets('Endless counter with 1 minute timeout and duration 200ms',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    tester.printToConsole('before pumpAndSettle ${tester.testDescription}');
    await tester.pumpAndSettle(const Duration(milliseconds: 200),
        EnginePhase.sendSemanticsUpdate, const Duration(minutes: 1));
  });
}
