import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/my_tickets/bloc/owned_tickets_cubit.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockOwnedTicketsRepository extends Mock
    implements OwnedTicketsRepository {}

OwnedTicket _ticket({
  required int productId,
  required String name,
  required int ticketsLeft,
}) {
  return OwnedTicket(
    productId: productId,
    ticketName: name,
    ticketsLeft: ticketsLeft,
    backgroundImagePath: 'assets/images/test.png',
  );
}

void main() {
  late _MockOwnedTicketsRepository repository;

  setUp(() {
    repository = _MockOwnedTicketsRepository();
  });

  group('OwnedTicketsCubit', () {
    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loading, Loaded(cache), Loaded(ordered)] when getOwnedTickets '
      'succeeds with cached order and depleted tickets',
      build: () {
        final cachedTickets = [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ];
        final fetchedTickets = [
          _ticket(productId: 2, name: 'T2', ticketsLeft: 4),
          _ticket(productId: 3, name: 'T3', ticketsLeft: 1),
        ];

        when(() => repository.getTicketsFromCache()).thenReturn(
          TaskEither.right(cachedTickets),
        );
        when(() => repository.fetchTicketsFromApi()).thenReturn(
          TaskEither.right(fetchedTickets),
        );
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.right(unit),
        );

        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      act: (cubit) => cubit.getOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedTickets.map((t) => t.productId).toList(),
          'cached productIds',
          [1, 2],
        ),
        isA<OwnedTicketsLoaded>()
            .having(
              (s) => s.ownedTickets.map((t) => t.productId).toList(),
              'ordered productIds',
              [3, 1, 2],
            )
            .having(
              (s) => s.ownedTickets
                  .firstWhere((t) => t.productId == 1)
                  .ticketsLeft,
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

        when(() => repository.getTicketsFromCache()).thenReturn(
          TaskEither.left(const LocalStorageFailure('cache-failed')),
        );
        when(() => repository.fetchTicketsFromApi()).thenReturn(
          TaskEither.right(fetchedTickets),
        );
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.right(unit),
        );

        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      act: (cubit) => cubit.getOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsLoading>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedTickets.map((t) => t.productId).toList(),
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

        when(() => repository.getTicketsFromCache()).thenReturn(
          TaskEither.right(cachedTickets),
        );
        when(() => repository.fetchTicketsFromApi()).thenReturn(
          TaskEither.left(const ConnectionFailure()),
        );

        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      act: (cubit) => cubit.getOwnedTickets(),
      verify: (_) {
        verifyNever(() => repository.cacheTickets(any()));
      },
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
      'throws AssertionError when getOwnedTickets called while loaded',
      build: () {
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [_ticket(productId: 1, name: 'T1', ticketsLeft: 1)],
      ),
      act: (cubit) => cubit.getOwnedTickets(),
      expect: () => <OwnedTicketsState>[],
      errors: () => [isA<AssertionError>()],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'throws AssertionError when getOwnedTickets called while loading',
      build: () {
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: OwnedTicketsLoading.new,
      act: (cubit) => cubit.getOwnedTickets(),
      expect: () => <OwnedTicketsState>[],
      errors: () => [isA<AssertionError>()],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Refreshing, Loaded(ordered)] when refresh succeeds',
      build: () {
        final fetchedTickets = [
          _ticket(productId: 2, name: 'T2', ticketsLeft: 3),
          _ticket(productId: 3, name: 'T3', ticketsLeft: 1),
        ];

        when(() => repository.fetchTicketsFromApi()).thenReturn(
          TaskEither.right(fetchedTickets),
        );
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.right(unit),
        );

        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.refreshOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsRefreshing>(),
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedTickets.map((t) => t.productId).toList(),
          'ordered productIds',
          [3, 1, 2],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Refreshing, Failure] when refresh fetch fails',
      build: () {
        when(() => repository.fetchTicketsFromApi()).thenReturn(
          TaskEither.left(const ConnectionFailure()),
        );

        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 2),
        ],
      ),
      act: (cubit) => cubit.refreshOwnedTickets(),
      expect: () => [
        isA<OwnedTicketsRefreshing>(),
        isA<OwnedTicketsFailure>(),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits nothing when refresh called while refreshing',
      build: () {
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsRefreshing(
        ownedTickets: [_ticket(productId: 1, name: 'T1', ticketsLeft: 1)],
      ),
      act: (cubit) => cubit.refreshOwnedTickets(),
      expect: () => <OwnedTicketsState>[],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'throws AssertionError when refresh called before load',
      build: () {
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: OwnedTicketsInitial.new,
      act: (cubit) => cubit.refreshOwnedTickets(),
      expect: () => <OwnedTicketsState>[],
      errors: () => [isA<AssertionError>()],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'does nothing when reorderTickets called before load',
      build: () {
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      act: (cubit) => cubit.reorderTickets(0, 1),
      verify: (_) {
        verifyNever(() => repository.cacheTickets(any()));
      },
      expect: () => <OwnedTicketsState>[],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loaded(reordered)] when reorder succeeds',
      build: () {
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.right(unit),
        );
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
          _ticket(productId: 3, name: 'T3', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.reorderTickets(0, 2),
      verify: (_) {
        verify(() => repository.cacheTickets(any())).called(1);
      },
      expect: () => [
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedTickets.map((t) => t.productId).toList(),
          'reordered productIds',
          [2, 1, 3],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits [Loaded(reordered), Failure] when reorder cache fails',
      build: () {
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.left(const LocalStorageFailure('cache-failed')),
        );
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.reorderTickets(0, 2),
      expect: () => [
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedTickets.map((t) => t.productId).toList(),
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
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      act: (cubit) => cubit.dismissDepletedTicket(1),
      verify: (_) {
        verifyNever(() => repository.cacheTickets(any()));
      },
      expect: () => <OwnedTicketsState>[],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits Failure when no depleted ticket matches product id',
      build: () {
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 1),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.dismissDepletedTicket(1),
      verify: (_) {
        verifyNever(() => repository.cacheTickets(any()));
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
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.right(unit),
        );
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
          _ticket(productId: 1, name: 'T1', ticketsLeft: 0),
          _ticket(productId: 2, name: 'T2', ticketsLeft: 1),
        ],
      ),
      act: (cubit) => cubit.dismissDepletedTicket(1),
      verify: (_) {
        verify(() => repository.cacheTickets(any())).called(1);
      },
      expect: () => [
        isA<OwnedTicketsLoaded>().having(
          (s) => s.ownedTickets.map((t) => t.productId).toList(),
          'remaining productIds',
          [2],
        ),
      ],
    );

    blocTest<OwnedTicketsCubit, OwnedTicketsState>(
      'emits Failure when dismiss cache fails',
      build: () {
        when(() => repository.cacheTickets(any())).thenReturn(
          TaskEither.left(const LocalStorageFailure('cache-failed')),
        );
        return OwnedTicketsCubit(ownedTicketsRepository: repository);
      },
      seed: () => OwnedTicketsLoaded(
        ownedTickets: [
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
