import 'package:cafe_analog_app/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache;

void main() {
  testWidgets('App can be instantiated', (tester) async {
    final router = GoRouter(
      routes: [GoRoute(path: '/', builder: (_, _) => const SizedBox.shrink())],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      App(localStorage: MockSharedPreferencesWithCache(), router: router),
    );
    expect(find.byType(App), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
  });
}
