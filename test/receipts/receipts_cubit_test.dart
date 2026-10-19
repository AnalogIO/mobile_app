import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockReceiptsRepository extends Mock implements ReceiptsRepository;

void main() {
  late _MockReceiptsRepository repository;

  final purchase = PurchaseReceipt(
    ticketName: 'Coffee',
    numberOfTickets: 10,
    status: PurchaseStatus.completed,
    priceDKK: 300,
    orderDate: DateTime(2026, 1, 2),
    orderId: 'order-1',
  );
  final swipe = UsedTicketReceipt(
    ticketName: 'Coffee',
    drinkName: 'Latte',
    swipeDate: DateTime(2026),
  );

  setUp(() {
    repository = _MockReceiptsRepository();
  });

  test('loadReceipts emits Loading then Loaded with the first page', () async {
    when(() => repository.fetchReceipts(type: GetReceiptsType.all)).thenAnswer(
      (_) => TaskEither.right(
        ReceiptsBatch(
          receipts: [purchase],
          continuationToken: 'next',
          hasMore: true,
        ),
      ),
    );

    final cubit = ReceiptsCubit(repository: repository);
    addTearDown(cubit.close);

    final states = <ReceiptsState>[];
    final subscription = cubit.stream.listen(states.add);
    addTearDown(subscription.cancel);

    await cubit.loadReceipts();
    await Future<void>.delayed(Duration.zero);

    expect(states, [isA<ReceiptsLoading>(), isA<ReceiptsLoaded>()]);
    final loaded = cubit.state as ReceiptsLoaded;
    expect(loaded.receipts, [purchase]);
    expect(loaded.continuationToken, 'next');
    expect(loaded.hasMore, isTrue);
  });

  test('loadMoreReceipts appends the next page', () async {
    when(() => repository.fetchReceipts(type: GetReceiptsType.all)).thenAnswer(
      (_) => TaskEither.right(
        ReceiptsBatch(
          receipts: [purchase],
          continuationToken: 'next',
          hasMore: true,
        ),
      ),
    );
    when(
      () => repository.fetchReceipts(
        type: GetReceiptsType.all,
        continuationToken: 'next',
      ),
    ).thenAnswer(
      (_) => TaskEither.right(
        ReceiptsBatch(
          receipts: [swipe],
          continuationToken: 'next-2',
          hasMore: false,
        ),
      ),
    );

    final cubit = ReceiptsCubit(repository: repository);
    addTearDown(cubit.close);

    await cubit.loadReceipts();
    await cubit.loadMoreReceipts();

    final loaded = cubit.state as ReceiptsLoaded;
    expect(loaded.receipts, [purchase, swipe]);
    expect(loaded.continuationToken, 'next-2');
    expect(loaded.hasMore, isFalse);
  });

  test(
    'a failed next page keeps the loaded receipts and exposes an error',
    () async {
      when(() => repository.fetchReceipts(type: GetReceiptsType.all))
          .thenAnswer(
            (_) => TaskEither.right(
              ReceiptsBatch(
                receipts: [purchase],
                continuationToken: 'next',
                hasMore: true,
              ),
            ),
          );
      when(
        () => repository.fetchReceipts(
          type: GetReceiptsType.all,
          continuationToken: 'next',
        ),
      ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('offline')));

      final cubit = ReceiptsCubit(repository: repository);
      addTearDown(cubit.close);

      await cubit.loadReceipts();
      await cubit.loadMoreReceipts();

      final loaded = cubit.state as ReceiptsLoaded;
      expect(loaded.receipts, [purchase]);
      expect(loaded.hasMore, isTrue);
      expect(loaded.loadMoreError, 'offline');
    },
  );

  test('loadMoreReceipts does nothing when there is no next page', () async {
    when(() => repository.fetchReceipts(type: GetReceiptsType.all)).thenAnswer(
      (_) => TaskEither.right(
        ReceiptsBatch(
          receipts: [purchase],
          continuationToken: 'next',
          hasMore: false,
        ),
      ),
    );

    final cubit = ReceiptsCubit(repository: repository);
    addTearDown(cubit.close);

    await cubit.loadReceipts();
    await cubit.loadMoreReceipts();

    verifyNever(
      () => repository.fetchReceipts(
        type: GetReceiptsType.all,
        continuationToken: 'next',
      ),
    );
  });
}
