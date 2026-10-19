import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:equatable/equatable.dart';

// TODO(marfavi): consider consolidating PurchasableTicketGroup and
//  OwnedTicketGroup into a single TicketGroup model with additional fields to
//  indicate ownership and depletion status. This would reduce code duplication
//  and simplify the data model, at the cost of potentially having some unused
//  fields in certain contexts.
// FIXME(marfavi): rename fields
class OwnedTicketGroup extends Equatable {
  const OwnedTicketGroup({
    required this.productId,
    required this.ticketName,
    required this.ticketsLeft,
    required this.eligibleDrinks,
  });

  // FIXME(marfavi): Use json_serializable instead?
  factory OwnedTicketGroup.fromJson(Map<String, dynamic> json) {
    return OwnedTicketGroup(
      productId: json['productId'] as int,
      ticketName: json['ticketName'] as String,
      ticketsLeft: json['ticketsLeft'] as int,
      eligibleDrinks: (json['eligibleDrinks'] as List<dynamic>)
          .map((e) => Drink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int productId;
  final String ticketName;
  final int ticketsLeft;
  final List<Drink> eligibleDrinks;

  bool get isDepleted => ticketsLeft <= 0;

  /// Returns a copy of this ticket with [ticketsLeft] set to 0 and no eligible
  /// drinks, effectively marking the ticket as depleted.
  OwnedTicketGroup asDepleted() => OwnedTicketGroup(
    productId: productId,
    ticketName: ticketName,
    ticketsLeft: 0,
    eligibleDrinks: const [],
  );

  @override
  List<Object?> get props => [
    productId,
    ticketName,
    ticketsLeft,
    eligibleDrinks,
  ];

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'ticketName': ticketName,
    'ticketsLeft': ticketsLeft,
    'eligibleDrinks': eligibleDrinks.map((e) => e.toJson()).toList(),
  };
}
