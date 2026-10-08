import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockTicketsRepository extends Mock implements TicketsRepository {}

const _ticketGroup = PurchasableTicketGroup(
  id: 1,
  title: 'Coffee clip card',
  description: '10 coffees',
  numberOfTickets: 10,
  priceDKK: 200,
  eligibleDrinks: [],
);

void main() {
  late _MockTicketsRepository repository;

  setUpAll(() {
    registerFallbackValue(PaymentMethod.mobilePay);
  });

  setUp(() {
    repository = _MockTicketsRepository();
  });

  group('PurchaseFlowCubit.initiatePurchase', () {
    final nexiPayment = InitiatedNexiPayment(
      orderId: 42,
      paymentUrl: Uri.parse('https://test.checkout.dibspayment.eu/hpp'),
    );

    blocTest<PurchaseFlowCubit, PurchaseFlowState>(
      'initiates the purchase with the chosen payment method',
      build: () {
        when(
          () => repository.initiatePurchase(
            ticketGroupId: any(named: 'ticketGroupId'),
            paymentMethod: any(named: 'paymentMethod'),
          ),
        ).thenReturn(TaskEither.right(nexiPayment));

        return PurchaseFlowCubit(repository: repository);
      },
      act: (cubit) => cubit.initiatePurchase(
        _ticketGroup,
        paymentMethod: PaymentMethod.nexi,
      ),
      expect: () => [
        const PurchaseInitiating(),
        PurchaseInitiated(initiatedPurchase: nexiPayment),
      ],
      verify: (_) {
        verify(
          () => repository.initiatePurchase(
            ticketGroupId: 1,
            paymentMethod: PaymentMethod.nexi,
          ),
        ).called(1);
      },
    );
  });
}
