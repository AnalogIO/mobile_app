import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/data/tickets_repository.dart';
import 'package:cafe_analog_app/features/tickets/models/drink.dart';
import 'package:cafe_analog_app/features/tickets/models/owned_ticket_group.dart';
import 'package:cafe_analog_app/features/tickets/presentation/my_tickets/bloc/owned_tickets_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockTicketRepository extends Mock implements TicketsRepository {}

Stream<Either<Failure, List<OwnedTicketGroup>>> _ownedTicketsLoadResults(
  List<Either<Failure, List<OwnedTicketGroup>>> results,
) {
  return Stream.fromIterable(results);
}

OwnedTicketGroup _ticket({
  required int productId,
  required String name,
  required int ticketsLeft,
  List<int> eligibleDrinkIds = const [0],
}) {
  return OwnedTicketGroup(
    productId: productId,
    ticketName: name,
    ticketsLeft: ticketsLeft,
    eligibleDrinks: eligibleDrinkIds
        .map((id) => Drink(id: id, name: 'Drink $id'))
        .toList(),
  );
}

void main() {
  late _MockTicketRepository repository;

  setUp(() {
    repository = _MockTicketRepository();
  });

  group('OwnedTicketsCubit', () {
    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'loadOwnedTickets: when cached ticket is missing from api, emits it as '
      'depleted with zero tickets and empty eligibleDrinkIds',
      build: () {
        final cachedTickets = [
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 2,
            eligibleDrinkIds: const [101, 102],
          ),
        ];
        final refreshedTickets = [cachedTickets.single.asDepleted()];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([
            Right(cachedTickets),
            Right(refreshedTickets),
          ]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>(),
        isA<OwnedTicketsLoaded>()
            .having(
              (s) => s.ownedGroups.single.productId,
              'depleted product id',
              1,
            )
            .having(
              (s) => s.ownedGroups.single.ticketsLeft,
              'depleted tickets left',
              0,
            )
            .having(
              (s) => s.ownedGroups.single.eligibleDrinks
                  .map((drink) => drink.id)
                  .toList(),
              'depleted ticket drink ids',
              <int>[],
            ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'loadOwnedTickets: when same cached ticket and api ticket have different '
      'eligibleDrinkIds, prefers api values for non-depleted tickets',
      build: () {
        final cachedTickets = [
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 2,
            eligibleDrinkIds: const [101, 102],
          ),
        ];
        final fetchedTickets = [
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 4,
            eligibleDrinkIds: const [202, 203],
          ),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([
            Right(cachedTickets),
            Right(fetchedTickets),
          ]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.single.eligibleDrinks
              .map((drink) => drink.id)
              .toList(),
          'cached ticket drink ids',
          [101, 102],
        ),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.single.eligibleDrinks
              .map((drink) => drink.id)
              .toList(),
          'fetched product drink ids',
          [202, 203],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'loadOwnedTickets: assigns fetched eligibleDrinkIds to brand-new tickets '
      'introduced by api',
      build: () {
        final cachedTickets = <OwnedTicketGroup>[];
        final fetchedTickets = [
          _ticket(
            productId: 3,
            name: 'T3',
            ticketsLeft: 1,
            eligibleDrinkIds: const [301],
          ),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([
            Right(cachedTickets),
            Right(fetchedTickets),
          ]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.single.eligibleDrinks
              .map((drink) => drink.id)
              .toList(),
          'new product drink ids',
          [301],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'loadOwnedTickets: replaces eligibleDrinkIds with fetched values and '
      'empties ids for tickets that become depleted',
      build: () {
        final refreshedTickets = [
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 0,
            eligibleDrinkIds: const [],
          ),
          _ticket(
            productId: 2,
            name: 'T2',
            ticketsLeft: 3,
            eligibleDrinkIds: const [22, 23],
          ),
        ];

        when(
          () => repository.refreshOwnedTickets(
            preferredOrder: any(named: 'preferredOrder'),
          ),
        ).thenReturn(TaskEither.right(refreshedTickets));

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 2,
            eligibleDrinkIds: const [11],
          ),
          _ticket(
            productId: 2,
            name: 'T2',
            ticketsLeft: 1,
            eligibleDrinkIds: const [99],
          ),
        ],
      ),
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsRefreshing>(),
        isA<OwnedTicketsLoaded>()
            .having(
              (s) => s.ownedGroups
                  .firstWhere((ticket) => ticket.productId == 2)
                  .eligibleDrinks
                  .map((drink) => drink.id)
                  .toList(),
              'product 2 drink ids refreshed',
              [22, 23],
            )
            .having(
              (s) => s.ownedGroups
                  .firstWhere((ticket) => ticket.productId == 1)
                  .eligibleDrinks
                  .map((drink) => drink.id)
                  .toList(),
              'depleted product 1 drink ids',
              <int>[],
            ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loading, Loaded(cache), Loaded(ordered)] when loadOwnedTickets '
      'succeeds with cached order and depleted tickets',
      build: () {
        final cachedTickets = [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ];
        final refreshedTickets = [
          _ticket(productId: 3, name: 'T3', ticketsLeft: 1),
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 0,
            eligibleDrinkIds: const [],
          ),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 4),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([
            Right(cachedTickets),
            Right(refreshedTickets),
          ]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'cached productIds',
          [1, 2],
        ),
        isA<OwnedTicketsLoaded>()
            .having(
              (s) => s.ownedGroups.map((t) => t.productId).toList(),
              'ordered productIds',
              [3, 1, 2],
            )
            .having(
              (s) =>
                  s.ownedGroups.firstWhere((t) => t.productId == 1).ticketsLeft,
              'ticket (id 1) with no tickets left',
              0,
            ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loading, Loaded(api)]'
      ' when getting from cache fails but fetch succeeds',
      build: () {
        final fetchedTickets = [
          _ticket(productId: 2, name: 'T2', ticketsLeft: 4),
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([Right(fetchedTickets)]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'api productIds',
          [2, 1],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loading, Loaded(cache), Failure] '
      ' when getting from cache succeeds but fetch fails',
      build: () {
        final cachedTickets = [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([
            Right(cachedTickets),
            const Left(ConnectionFailure()),
          ]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>(),
        isA<OwnedTicketsFailure>().having(
          (s) => s.reason,
          'reason',
          'Could not reach the server',
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'recovers from failure state when loadOwnedTickets is called',
      build: () {
        final fetchedTickets = [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([Right(fetchedTickets)]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => const OwnedTicketsFailure(reason: 'Some previous failure'),
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>(),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'does nothing when loadOwnedTickets called while loading',
      build: () {
        return OwnedTicketsCubit(repository: repository);
      },
      seed: OwnedTicketsLoading.new,
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => <OwnedTicketsState>[],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Refreshing, Loaded(ordered)] when loadOwnedTickets refreshes '
      'successfully',
      build: () {
        final refreshedTickets = [
          _ticket(productId: 3, name: 'T3', ticketsLeft: 1),
          _ticket(
            productId: 1,
            name: 'T1',
            ticketsLeft: 0,
            eligibleDrinkIds: const [],
          ),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 3),
        ];

        when(
          () => repository.refreshOwnedTickets(
            preferredOrder: any(named: 'preferredOrder'),
          ),
        ).thenReturn(TaskEither.right(refreshedTickets));

        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsRefreshing>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'ordered productIds',
          [3, 1, 2],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Refreshing, Failure] when refresh fetch fails',
      build: () {
        when(
          () => repository.refreshOwnedTickets(
            preferredOrder: any(named: 'preferredOrder'),
          ),
        ).thenReturn(TaskEither.left(const ConnectionFailure()));

        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
        ],
      ),
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsRefreshing>(),
        isA<OwnedTicketsFailure>(),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loaded] when loadOwnedTickets called while refreshing',
      build: () {
        when(
          () => repository.refreshOwnedTickets(
            preferredOrder: any(named: 'preferredOrder'),
          ),
        ).thenReturn(
          TaskEither.right([_ticket(productId: 1, name: 'T1', ticketsLeft: 1)]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsRefreshing(
        ownedGroups: [_ticket(productId: 1, name: 'T1', ticketsLeft: 1)],
      ),
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoaded>(),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'loads tickets when called from initial state',
      build: () {
        final fetchedTickets = [
          _ticket(productId: 2, name: 'T2', ticketsLeft: 4),
        ];

        when(() => repository.getOwnedTickets()).thenAnswer(
          (_) => _ownedTicketsLoadResults([Right(fetchedTickets)]),
        );

        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.loadOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'api productIds',
          [2],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'does nothing when reorderTickets called before load',
      build: () {
        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.reorderTickets(0, 1),
      verify: (_) {
        verifyNever(() => repository.saveOwnedTicketsOrder(any()));
      },
      expect: () => <OwnedTicketsState>[],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loaded(reordered)] when reorder succeeds',
      build: () {
        when(() => repository.saveOwnedTicketsOrder(any())).thenReturn(
          TaskEither.right(unit),
        );
        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
          _ticket(productId: 3, name: 'T3', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.reorderTickets(0, 1),
      verify: (_) {
        verify(() => repository.saveOwnedTicketsOrder(any())).called(1);
      },
      expect: () => [
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'reordered productIds',
          [2, 1, 3],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loaded(reordered), Failure] when reorder cache fails',
      build: () {
        when(() => repository.saveOwnedTicketsOrder(any())).thenReturn(
          TaskEither.left(const LocalStorageFailure('cache-failed')),
        );
        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.reorderTickets(0, 1),
      expect: () => [
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'reordered productIds',
          [2, 1],
        ),
        isA<OwnedTicketsFailure>().having(
          (s) => s.reason,
          'reason',
          'cache-failed',
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'does nothing when dismissDepletedTicket called before load',
      build: () {
        return OwnedTicketsCubit(repository: repository);
      },
      act: (cubit) => cubit.dismissDepletedTicket(1),
      verify: (_) {
        verifyNever(() => repository.saveOwnedTicketsOrder(any()));
      },
      expect: () => <OwnedTicketsState>[],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits Failure when no depleted ticket matches product id',
      build: () {
        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.dismissDepletedTicket(1),
      verify: (_) {
        verifyNever(() => repository.saveOwnedTicketsOrder(any()));
      },
      expect: () => [
        isA<OwnedTicketsFailure>().having(
          (s) => s.reason,
          'reason',
          'No depleted ticket with product id 1 found',
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits Loaded with updated list when dismiss succeeds',
      build: () {
        when(() => repository.saveOwnedTicketsOrder(any())).thenReturn(
          TaskEither.right(unit),
        );
        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 0),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.dismissDepletedTicket(1),
      verify: (_) {
        verify(() => repository.saveOwnedTicketsOrder(any())).called(1);
      },
      expect: () => [
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedGroups.map((t) => t.productId).toList(),
          'remaining productIds',
          [2],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits Failure when dismiss cache fails',
      build: () {
        when(() => repository.saveOwnedTicketsOrder(any())).thenReturn(
          TaskEither.left(const LocalStorageFailure('cache-failed')),
        );
        return OwnedTicketsCubit(repository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedGroups: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 0),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.dismissDepletedTicket(1),
      expect: () => [
        isA<OwnedTicketsFailure>().having(
          (s) => s.reason,
          'reason',
          'cache-failed',
        ),
      ],
    );
  });
}
