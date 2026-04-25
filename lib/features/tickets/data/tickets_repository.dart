import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class TicketsRepository {
  const TicketsRepository({
    required TicketsApi ticketsApi,
    required OwnedTicketsLocalStore ownedTicketsLocalStore,
    required DrinksLocalStore drinksLocalStore,
    required PurchasableTicketsLocalStore purchasableTicketsLocalStore,
    required RememberedTicketDrinkLocalStore rememberedTicketDrinkLocalStore,
  }) : _ticketsApi = ticketsApi,
       _ownedTicketsLocalStore = ownedTicketsLocalStore,
       _drinksLocalStore = drinksLocalStore,
       _purchasableTicketsLocalStore = purchasableTicketsLocalStore,
       _rememberedTicketDrinkLocalStore = rememberedTicketDrinkLocalStore;

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

  /// Initiates a purchase flow for a ticket group by id.
  TaskEither<Failure, Unit> buyTicketGroup({required int ticketGroupId}) {
    throw UnimplementedError();
    return _ticketsApi
        .initiateMobilePayPurchase(ticketGroupId: ticketGroupId)
        .map((_) => unit);
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
}
