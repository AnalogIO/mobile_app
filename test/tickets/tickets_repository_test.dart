import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockTicketsApi extends Mock implements TicketsApi;

class _MutableString {
  String? value;
}

class _FakeSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache {
  final state = _MutableString();
}

void main() {
  late _MockTicketsApi api;
  late _FakeSharedPreferencesWithCache preferences;
  late OwnedTicketsLocalStore store;
  late TicketsRepository repository;

  setUp(() {
    api = _MockTicketsApi();
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
    when(
      () => api.fetchOwnedTickets(),
    ).thenReturn(TaskEither<Failure, List<GroupedTicketsResponse>>.right([]));

    repository = TicketsRepository(
      ticketsApi: api,
      ownedTicketsLocalStore: store,
      drinksLocalStore: DrinksLocalStore(),
      purchasableTicketsLocalStore: PurchasableTicketsLocalStore(),
      rememberedTicketDrinkLocalStore: RememberedTicketDrinkLocalStore(
        store: preferences,
      ),
    );
  });

  test(
    'does not merge stale cached tickets after the cache is cleared',
    () async {
      await store.set(const [
        OwnedTicketGroup(
          productId: 1,
          ticketName: 'Dummy Seed - 10 Coffee Clips',
          ticketsLeft: 3,
          eligibleDrinks: [],
        ),
        OwnedTicketGroup(
          productId: 2,
          ticketName: 'Dummy Seed - 5 Tea Clips',
          ticketsLeft: 1,
          eligibleDrinks: [],
        ),
      ]).run();

      // This is what logging out does before another account signs in.
      await store.clear().run();

      final emissions = await repository.getOwnedTickets().toList();

      expect(emissions, hasLength(1));
      expect(emissions.single.getOrElse((_) => []), isEmpty);
    },
  );
}
