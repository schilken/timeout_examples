import 'package:flutter_test/flutter_test.dart';

extension PumpAndSettleWithTtimeout on WidgetTester {
  Future<int> pumpAndSettleWithTimeout({int seconds = 30}) async {
    return pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, Duration(seconds: seconds));
  }

}
