import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:fpdart/fpdart.dart';

/// In-memory cache for drink info (called "menu items" in the API).
class DrinksLocalStore {
  List<Drink> _cachedDrinks = [];

  Unit set(List<Drink> drinks) {
    _cachedDrinks = drinks;
    return unit;
  }

  TaskEither<Failure, List<Drink>> get() {
    if (_cachedDrinks.isEmpty) {
      return TaskEither.left(
        const LocalStorageFailure('No cached drinks found'),
      );
    }
    return TaskEither.right(_cachedDrinks);
  }
}
