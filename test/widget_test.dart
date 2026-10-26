import 'package:flutter_test/flutter_test.dart';
import 'package:dompet_harian/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DompetHarianApp());
    await tester.pump(const Duration(milliseconds: 300));
  });
}
