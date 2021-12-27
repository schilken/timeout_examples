import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:timeout_examples/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Endless counter with defaultTimeout',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      tester.printToConsole('before pumpAndSettle ${tester.testDescription}');
      await tester.pumpAndSettle();
    },
    skip: true,
  );
}
