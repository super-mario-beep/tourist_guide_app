import 'package:flutter_test/flutter_test.dart';

import 'package:tourist_guide_app/main.dart';

void main() {
  testWidgets('Home screen shows text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Tourist Guide'), findsOneWidget);
  });
}
