import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Calculator design renders static UI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculatorDesignApp());

    expect(find.text('CALCULADORA'), findsOneWidget);
    expect(find.text('165'), findsOneWidget);
  });
}
