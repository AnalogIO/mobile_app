import 'package:cafe_analog_app/features/tickets/models/drink.dart';
import 'package:equatable/equatable.dart';

// TODO(marfavi): consider consolidating PurchasableTicketGroup and
//  OwnedTicketGroup into a single TicketGroup model with additional fields to
//  indicate ownership and depletion status. This would reduce code duplication
//  and simplify the data model, at the cost of potentially having some unused
//  fields in certain contexts.
// FIXME(marfavi): rename fields
class PurchasableTicketGroup extends Equatable {
  const PurchasableTicketGroup({
    required this.id,
    required this.title,
    required this.description,
    required this.numberOfTickets,
    required this.priceDKK,
    required this.eligibleDrinks,
  });

  final int id;
  final String title;
  final String description;
  final int numberOfTickets;
  final int priceDKK;
  final List<Drink> eligibleDrinks;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    numberOfTickets,
    priceDKK,
    eligibleDrinks,
  ];
}
