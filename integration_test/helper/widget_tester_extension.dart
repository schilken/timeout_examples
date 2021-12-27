import 'package:flutter_test/flutter_test.dart';

extension PumpAndSettleWithTimeout on WidgetTester {
  Future<int> pumpAndSettleWithTimeout({int seconds = 30}) async {
    return pumpAndSettle(const Duration(milliseconds: 100),
        EnginePhase.sendSemanticsUpdate, Duration(seconds: seconds));
  }

  Future<void> pumpNtimes({int times = 3}) async {
    return await Future.forEach(
        Iterable.generate(times), (_) async => await pump());
  }
}
