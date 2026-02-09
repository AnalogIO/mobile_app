import 'package:cafe_analog_app/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache {}

void main() {
  testWidgets('App can be instantiated', (tester) async {
    await tester.pumpWidget(
      App(localStorage: MockSharedPreferencesWithCache()),
    );
    expect(find.byType(App), findsOneWidget);
  });
}
