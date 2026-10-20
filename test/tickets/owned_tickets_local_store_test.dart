import 'package:cafe_analog_app/features/tickets/data/data_providers/owned_tickets_local_store.dart';
import 'package:cafe_analog_app/features/tickets/models/owned_ticket_group.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MutableString {
  String? value;
}

class _FakeSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache {
  final state = _MutableString();
}

void main() {
  late _FakeSharedPreferencesWithCache preferences;
  late OwnedTicketsLocalStore store;

  setUp(() {
    preferences = _FakeSharedPreferencesWithCache();
    store = OwnedTicketsLocalStore(store: preferences);

    when(() => preferences.getString(OwnedTicketsLocalStore.storageKey))
        .thenAnswer((_) => preferences.state.value);
    when(() => preferences.setString(any(), any()))
        .thenAnswer((invocation) async {
          preferences.state.value = invocation.positionalArguments[1] as String;
        });
    when(() => preferences.remove(OwnedTicketsLocalStore.storageKey))
        .thenAnswer((_) async {
          preferences.state.value = null;
        });
  });

  test('clear removes the cached tickets', () async {
    const tickets = [
      OwnedTicketGroup(
        productId: 1,
        ticketName: 'Coffee',
        ticketsLeft: 2,
        eligibleDrinks: [],
      ),
    ];

    expect((await store.set(tickets).run()).isRight(), isTrue);
    expect((await store.get().run()).getOrElse((_) => []), tickets);

    expect((await store.clear().run()).isRight(), isTrue);
    expect((await store.get().run()).isLeft(), isTrue);
  });

  test('clear returns a failure when the cache cannot be written', () async {
    when(() => preferences.remove(OwnedTicketsLocalStore.storageKey))
        .thenThrow(Exception('storage unavailable'));

    final result = await store.clear().run();

    expect(result.isLeft(), isTrue);
  });
}
