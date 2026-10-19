import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:fpdart/fpdart.dart';

class PurchasableTicketsLocalStore {
  Option<List<PurchasableTicketGroup>> _cachedGroups = none();

  TaskEither<Failure, List<PurchasableTicketGroup>> get() {
    return TaskEither<Failure, List<PurchasableTicketGroup>>.fromOption(
      _cachedGroups,
      () => const LocalStorageFailure('Cache is empty'),
    );
  }

  Unit save(List<PurchasableTicketGroup> groups) {
    _cachedGroups = some(groups);
    return unit;
  }
}
