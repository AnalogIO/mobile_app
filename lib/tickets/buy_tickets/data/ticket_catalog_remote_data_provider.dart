import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/http/http.dart';
import 'package:fpdart/fpdart.dart';

class TicketCatalogRemoteDataProvider {
  const TicketCatalogRemoteDataProvider({
    required NetworkRequestExecutor executor,
  }) : _executor = executor;

  final NetworkRequestExecutor _executor;

  /// Fetches products available for the user.
  TaskEither<Failure, List<ProductResponse>> getProducts() {
    return _executor.run((api) => api.v2.productsGet());
  }

  /// Fetches all drinks ("menu items" in the API) available for the user.
  TaskEither<Failure, List<MenuItemResponse>> getMenuItems() {
    return _executor.run((api) => api.v2.menuitemsGet());
  }
}
