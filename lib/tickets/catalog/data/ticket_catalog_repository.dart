import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';
import 'package:cafe_analog_app/tickets/catalog/data/drinks_local_data_provider.dart';
import 'package:cafe_analog_app/tickets/catalog/data/ticket_catalog_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:fpdart/fpdart.dart';

class TicketCatalogRepository {
  const TicketCatalogRepository({
    required TicketCatalogRemoteDataProvider remoteDataProvider,
    required DrinksLocalDataProvider drinksLocalDataProvider,
  }) : _remoteDataProvider = remoteDataProvider,
       _drinksLocalDataProvider = drinksLocalDataProvider;

  final TicketCatalogRemoteDataProvider _remoteDataProvider;
  final DrinksLocalDataProvider _drinksLocalDataProvider;

  TaskEither<Failure, List<Drink>> getDrinks() {
    return _drinksLocalDataProvider.get().alt(
      () => _remoteDataProvider.getMenuItems().map(
        (rs) => rs.map((r) => Drink(id: r.id, name: r.name)).toList(),
      ),
    );
  }

  /// Fetches visible, non-perk products and maps them to the UI model.
  TaskEither<Failure, List<Product>> fetchBuyableProducts() {
    return _remoteDataProvider.getProducts().map(
      (responses) => responses
          .where((response) => response.visible && !response.isPerk)
          .map(
            (response) => Product(
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
    );
  }
}
