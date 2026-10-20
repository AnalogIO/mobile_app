import 'package:cafe_analog_app/app/user_context_cleaner.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache;

void main() {
  late _MockSharedPreferencesWithCache store;
  late UserContextCleaner cleaner;

  setUp(() {
    store = _MockSharedPreferencesWithCache();
    cleaner = UserContextCleaner(localStorage: store);
    when(() => store.remove(any())).thenAnswer((_) async {});
  });

  test(
    'clears owned tickets so they cannot leak into the next account',
    () async {
      await cleaner.clear();

      verify(() => store.remove(OwnedTicketsLocalStore.storageKey)).called(1);
    },
  );

  test('clears remembered drinks and the profile picture', () async {
    await cleaner.clear();

    verify(() => store.remove(RememberedTicketDrinkLocalStore.storageKey))
        .called(1);
    verify(() => store.remove(ProfilePictureLocalStore.iconKey)).called(1);
    verify(() => store.remove(ProfilePictureLocalStore.backgroundColorKey))
        .called(1);
  });

  test('keeps clearing other caches when one removal fails', () async {
    when(() => store.remove(any())).thenAnswer((invocation) async {
      final key = invocation.positionalArguments.first as String;
      if (key == OwnedTicketsLocalStore.storageKey) {
        throw Exception('storage unavailable');
      }
    });

    await cleaner.clear();

    verify(() => store.remove(RememberedTicketDrinkLocalStore.storageKey))
        .called(1);
    verify(() => store.remove(ProfilePictureLocalStore.backgroundColorKey))
        .called(1);
  });
}
