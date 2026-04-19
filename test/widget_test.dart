import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rummy_scorekeeper/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const RummyScoreApp());
    await tester.pumpAndSettle();

    expect(find.text('Gin Rummy Scorekeeper'), findsOneWidget);
  });
}
