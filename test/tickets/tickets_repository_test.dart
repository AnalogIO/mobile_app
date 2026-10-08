import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockTicketsApi extends Mock implements TicketsApi {}

class _MockOwnedTicketsLocalStore extends Mock
    implements OwnedTicketsLocalStore {}

class _MockDrinksLocalStore extends Mock implements DrinksLocalStore {}

class _MockPurchasableTicketsLocalStore extends Mock
    implements PurchasableTicketsLocalStore {}

class _MockRememberedTicketDrinkLocalStore extends Mock
    implements RememberedTicketDrinkLocalStore {}

api.InitiatePurchaseResponse _response(Map<String, dynamic> paymentDetails) {
  return api.InitiatePurchaseResponse(
    id: 42,
    dateCreated: DateTime(2026, 10),
    productId: 1,
    productName: 'Coffee clip card',
    totalAmount: 200,
    purchaseStatus: 'PendingPayment',
    paymentDetails: paymentDetails,
  );
}

void main() {
  late _MockTicketsApi ticketsApi;
  late TicketsRepository repository;

  setUpAll(() {
    registerFallbackValue(api.PaymentType.mobilepay);
  });

  setUp(() {
    ticketsApi = _MockTicketsApi();
    repository = TicketsRepository(
      ticketsApi: ticketsApi,
      ownedTicketsLocalStore: _MockOwnedTicketsLocalStore(),
      drinksLocalStore: _MockDrinksLocalStore(),
      purchasableTicketsLocalStore: _MockPurchasableTicketsLocalStore(),
      rememberedTicketDrinkLocalStore: _MockRememberedTicketDrinkLocalStore(),
    );
  });

  void stubInitiatePurchase(
    TaskEither<Failure, api.InitiatePurchaseResponse> result,
  ) {
    when(
      () => ticketsApi.initiatePurchase(
        ticketGroupId: any(named: 'ticketGroupId'),
        paymentType: any(named: 'paymentType'),
      ),
    ).thenReturn(result);
  }

  group('TicketsRepository.initiatePurchase', () {
    test('with MobilePay, returns the MobilePay redirect URI', () async {
      stubInitiatePurchase(
        TaskEither.right(
          _response({
            'discriminator': 'MobilePayPaymentDetails',
            'paymentType': 'MobilePay',
            'orderId': 'order-id',
            'paymentId': 'payment-id',
            'mobilePayAppRedirectUri': 'mobilepay://pay',
          }),
        ),
      );

      final result = await repository
          .initiatePurchase(
            ticketGroupId: 1,
            paymentMethod: PaymentMethod.mobilePay,
          )
          .run();

      expect(
        result.getRight().toNullable(),
        InitiatedMobilePayPayment(
          orderId: 42,
          mobilePayRedirectUri: Uri.parse('mobilepay://pay'),
        ),
      );
      verify(
        () => ticketsApi.initiatePurchase(
          ticketGroupId: 1,
          paymentType: api.PaymentType.mobilepay,
        ),
      ).called(1);
    });

    test('with Nexi, returns the hosted payment page URL', () async {
      stubInitiatePurchase(
        TaskEither.right(
          _response({
            'discriminator': 'NexiPaymentDetails',
            'paymentType': 'Nexi',
            'orderId': 'order-id',
            'paymentUrl': 'https://test.checkout.dibspayment.eu/hpp',
          }),
        ),
      );

      final result = await repository
          .initiatePurchase(ticketGroupId: 1, paymentMethod: PaymentMethod.nexi)
          .run();

      expect(
        result.getRight().toNullable(),
        InitiatedNexiPayment(
          orderId: 42,
          paymentUrl: Uri.parse('https://test.checkout.dibspayment.eu/hpp'),
        ),
      );
      verify(
        () => ticketsApi.initiatePurchase(
          ticketGroupId: 1,
          paymentType: api.PaymentType.nexi,
        ),
      ).called(1);
    });

    test('maps an API failure to a PurchaseInitiationFailure', () async {
      stubInitiatePurchase(
        TaskEither.left(const UnexpectedFailure('Server error')),
      );

      final result = await repository
          .initiatePurchase(ticketGroupId: 1, paymentMethod: PaymentMethod.nexi)
          .run();

      expect(
        result.getLeft().toNullable(),
        isA<PurchaseInitiationFailure>().having(
          (failure) => failure.reason,
          'reason',
          'Server error',
        ),
      );
    });
  });
}
