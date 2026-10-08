import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class TicketsRepository {
  const TicketsRepository({
    required this._ticketsApi,
    required this._ownedTicketsLocalStore,
    required this._drinksLocalStore,
    required this._purchasableTicketsLocalStore,
    required this._rememberedTicketDrinkLocalStore,
  });

  final TicketsApi _ticketsApi;
  final OwnedTicketsLocalStore _ownedTicketsLocalStore;
  final DrinksLocalStore _drinksLocalStore;
  final PurchasableTicketsLocalStore _purchasableTicketsLocalStore;
  final RememberedTicketDrinkLocalStore _rememberedTicketDrinkLocalStore;

  /// Spend a ticket with the given [ticketId]
  /// on a drink with the given [drinkId].
  TaskEither<Failure, SpentTicketInfo> spendTicket({
    required int ticketId,
    required int drinkId,
  }) {
    return _ticketsApi
        .useTicket(ticketId: ticketId, drinkId: drinkId)
        .flatMap(
          (response) => _rememberedTicketDrinkLocalStore
              .setLastSelectedDrinkId(ticketGroupId: ticketId, drinkId: drinkId)
              .map((_) => response),
        )
        .map(
          (response) => SpentTicketInfo(
            // menuItemName can be null for backwards compatibility reasons
            drinkName: response.menuItemName ?? 'Some ${response.productName}',
            ticketName: response.productName,
            usedAt: response.dateUsed,
          ),
        );
  }

  /// Returns the remembered drink for [ticketGroupId] if it's still eligible.
  Drink? getRememberedDrinkSelection({
    required int ticketGroupId,
    required List<Drink> eligibleDrinks,
  }) {
    final rememberedDrinkId = _rememberedTicketDrinkLocalStore
        .getLastSelectedDrinkId(ticketGroupId: ticketGroupId);

    if (rememberedDrinkId == null) {
      return null;
    }

    return eligibleDrinks.firstWhereOrNull(
      (drink) => drink.id == rememberedDrinkId,
    );
  }

  /// Clears remembered drink selections for all ticket products.
  TaskEither<Failure, Unit> clearRememberedDrinkSelections() {
    return _rememberedTicketDrinkLocalStore.clear();
  }

  /// Get all drinks available for the user.
  TaskEither<Failure, List<Drink>> getDrinks() {
    return _drinksLocalStore.get().alt(
      () => _ticketsApi.fetchMenuItems().map(
        (responses) => responses
            .map((response) => Drink(id: response.id, name: response.name))
            .toList(),
      ),
    );
  }

  /// Initiate a purchase flow for a ticket group by id.
  TaskEither<PurchaseInitiationFailure, InitiatedPayment> initiatePurchase({
    required int ticketGroupId,
    required PaymentMethod paymentMethod,
  }) {
    final paymentType = switch (paymentMethod) {
      PaymentMethod.mobilePay => PaymentType.mobilepay,
      PaymentMethod.nexi => PaymentType.nexi,
    };

    return _ticketsApi
        .initiatePurchase(
          ticketGroupId: ticketGroupId,
          paymentType: paymentType,
        )
        // map Left type from Failure to PurchaseInitiationFailure
        .mapLeft((failure) => PurchaseInitiationFailure(failure.reason))
        .map((response) => _toInitiatedPayment(response, paymentMethod));
  }

  /// Verify the status of a purchase flow for a ticket group.
  ///
  /// Returns a `Some` with the successful purchase info if the purchase is
  /// completed, otherwise `None`.
  TaskEither<PurchaseVerificationFailure, SuccessfulPurchase> verifyPurchase({
    required int orderId,
  }) {
    return _fetchPurchaseUntilSettled(orderId: orderId)
        // map Left type from Failure to PurchaseVerificationFailure
        .mapLeft<PurchaseVerificationFailure>(
          (failure) => PurchaseUnexpectedFailure(failure.reason),
        )
        .flatMap(
          (response) {
            return TaskEither(() async {
              final purchaseStatus = purchaseStatusFromJson(
                response.purchaseStatus,
              );

              if (purchaseStatus == PurchaseStatus.cancelled) {
                return const Left(PurchaseCancelledByUser());
              }
              if (purchaseStatus == PurchaseStatus.pendingpayment) {
                return const Left(PurchasePending());
              }
              if (purchaseStatus != PurchaseStatus.completed) {
                return const Left(PurchaseUnexpectedFailure());
              }

              // the response doesn't include info about the purchased ticket
              // group other than its id, so we need to get the ticket group
              // details from the list of purchasable tickets.
              final successfulPurchase = await _purchasableTicketsLocalStore
                  .get()
                  .map(
                    (groups) => groups.firstWhereOrNull(
                      (group) => group.id == response.productId,
                    ),
                  )
                  .getOrElse((_) => null)
                  .map((purchasedTicketGroup) {
                    if (purchasedTicketGroup != null) {
                      return SuccessfulPurchase(
                        ticketName: purchasedTicketGroup.title,
                        amountOfTickets: purchasedTicketGroup.numberOfTickets,
                      );
                    } else {
                      // this should never happen, but if it does, we can still
                      // proceed with showing a generic success message
                      return const SuccessfulPurchase(
                        ticketName: 'Some tickets',
                        amountOfTickets: 0,
                      );
                    }
                  })
                  .run();

              return Right(successfulPurchase);
            });
          },
        );
  }

  /// How many times [_fetchPurchaseUntilSettled] fetches a pending purchase.
  static const _purchaseVerificationAttempts = 10;

  /// How long [_fetchPurchaseUntilSettled] waits between attempts.
  static const _purchaseVerificationRetryDelay = Duration(seconds: 1);

  /// Fetches the purchase with the given [orderId], fetching it again while
  /// the backend still reports it as pending.
  ///
  /// The backend only updates the status when the payment provider notifies
  /// it (by webhook), which can happen after the user has returned to the app.
  /// Gives up after [attemptsLeft] attempts and returns the pending purchase.
  TaskEither<Failure, SinglePurchaseResponse> _fetchPurchaseUntilSettled({
    required int orderId,
    int attemptsLeft = _purchaseVerificationAttempts,
  }) {
    return _ticketsApi.verifyPurchase(orderId: orderId).flatMap((response) {
      final isPending =
          purchaseStatusFromJson(response.purchaseStatus) ==
          PurchaseStatus.pendingpayment;
      if (!isPending || attemptsLeft <= 1) {
        return TaskEither.right(response);
      }

      return _fetchPurchaseUntilSettled(
        orderId: orderId,
        attemptsLeft: attemptsLeft - 1,
      ).delay(_purchaseVerificationRetryDelay);
    });
  }

  /// Get the list of purchasable ticket groups.
  TaskEither<Failure, List<PurchasableTicketGroup>> getPurchasableTickets() {
    return _purchasableTicketsLocalStore.get().alt(
      () => _ticketsApi
          .fetchPurchasableTickets()
          .map(
            (responses) => responses
                .where((response) => response.visible && !response.isPerk)
                .map(
                  (response) => PurchasableTicketGroup(
                    id: response.id,
                    title: response.name,
                    description: response.description,
                    numberOfTickets: response.numberOfTickets,
                    priceDKK: response.price,
                    eligibleDrinks:
                        response.eligibleMenuItems
                            ?.where((item) => item.active)
                            .map((item) => Drink(id: item.id, name: item.name))
                            .toList() ??
                        // use an empty list is eligibleMenuItems is null
                        //  - it can be null for backwards compatibility reasons
                        [],
                  ),
                )
                .toList(),
          )
          .map((groups) {
            _purchasableTicketsLocalStore.save(groups);
            return groups;
          }),
    );
  }

  /// Returns owned tickets in two stages:
  /// 1) cached tickets if available
  /// 2) refreshed tickets fetched from the API and persisted locally
  ///
  /// If reading cache fails, the stream skips stage 1 and only emits stage 2.
  Stream<Either<Failure, List<OwnedTicketGroup>>> getOwnedTickets() async* {
    final cachedResult = await _ownedTicketsLocalStore.get().run();

    List<OwnedTicketGroup>? preferredOrder;
    cachedResult.match(
      (_) => null,
      (cachedTickets) {
        preferredOrder = cachedTickets;
        return null;
      },
    );

    if (preferredOrder != null) {
      yield Right(preferredOrder!);
    }

    yield await _fetchAndPersistOwnedTickets(
      preferredOrder: preferredOrder,
    ).run();
  }

  /// Refreshes owned tickets from the API while preserving [preferredOrder]
  /// from the current UI state.
  TaskEither<Failure, List<OwnedTicketGroup>> refreshOwnedTickets({
    required List<OwnedTicketGroup> preferredOrder,
  }) {
    return _fetchAndPersistOwnedTickets(preferredOrder: preferredOrder);
  }

  /// Persists the given owned tickets list.
  TaskEither<Failure, Unit> saveOwnedTicketsOrder(
    List<OwnedTicketGroup> preferredOrder,
  ) {
    return _ownedTicketsLocalStore.set(preferredOrder);
  }

  /// Attempt to redeem a voucher code that grants tickets to the user.
  TaskEither<Failure, OwnedTicketGroup> redeemVoucher({
    required String voucherCode,
  }) {
    return _ticketsApi
        .redeemVoucher(voucherCode: voucherCode)
        .map(
          (response) => OwnedTicketGroup(
            productId: response.productId,
            ticketName: response.productName,
            ticketsLeft: response.numberOfTickets,
            eligibleDrinks: const [],
          ),
        );
  }

  TaskEither<Failure, List<OwnedTicketGroup>> _fetchAndPersistOwnedTickets({
    required List<OwnedTicketGroup>? preferredOrder,
  }) {
    return _fetchOwnedTicketsFromApi()
        .map(
          (fetchedTickets) => _mergeOwnedTickets(
            preferredOrder: preferredOrder,
            fetchedTickets: fetchedTickets,
          ),
        )
        .flatMap(
          (ownedTickets) =>
              saveOwnedTicketsOrder(ownedTickets).map((_) => ownedTickets),
        );
  }

  TaskEither<Failure, List<OwnedTicketGroup>> _fetchOwnedTicketsFromApi() {
    return _ticketsApi.fetchOwnedTickets().map(
      (responses) => responses
          .map(
            (response) => OwnedTicketGroup(
              productId: response.productId,
              ticketName: response.productName,
              ticketsLeft: response.ticketsLeft,
              eligibleDrinks: response.eligibleMenuItems
                  // TODO(marfavi): why are we getting ineligible drinks from
                  //  the API and having to filter them out client-side?
                  // .where((item) => item.active)
                  .map((item) => Drink(id: item.id, name: item.name))
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  List<OwnedTicketGroup> _mergeOwnedTickets({
    required List<OwnedTicketGroup>? preferredOrder,
    required List<OwnedTicketGroup> fetchedTickets,
  }) {
    if (preferredOrder == null) {
      return fetchedTickets;
    }

    final fetchedProductIds = fetchedTickets
        .map((ticket) => ticket.productId)
        .toSet();
    final depletedTickets = preferredOrder
        .where((ticket) => !fetchedProductIds.contains(ticket.productId))
        .map((ticket) => ticket.asDepleted());

    final allTickets = fetchedTickets.followedBy(depletedTickets);

    final preferredOrderByProductId = {
      for (final (index, ticket) in preferredOrder.indexed)
        ticket.productId: index,
    };

    // Tickets not seen before have no preferred order and therefore appear
    // first in the list.
    return allTickets.sortedBy(
      (ticket) => preferredOrderByProductId[ticket.productId] ?? -1,
    );
  }

  static InitiatedPayment _toInitiatedPayment(
    InitiatePurchaseResponse response,
    PaymentMethod paymentMethod,
  ) {
    final paymentDetails = response.paymentDetails as Map<String, dynamic>;

    return switch (paymentMethod) {
      PaymentMethod.mobilePay => InitiatedMobilePayPayment(
        orderId: response.id,
        mobilePayRedirectUri: Uri.parse(
          MobilePayPaymentDetails.fromJson(paymentDetails)
              .mobilePayAppRedirectUri,
        ),
      ),
      PaymentMethod.nexi => InitiatedNexiPayment(
        orderId: response.id,
        paymentUrl: Uri.parse(
          NexiPaymentDetails.fromJson(paymentDetails).paymentUrl,
        ),
      ),
    };
  }
}
