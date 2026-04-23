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
    required this.title,
    required this.description,
    required this.numberOfTickets,
    required this.priceDKK,
    required this.eligibleDrinks,
  });

  final String title;
  final String description;
  final int numberOfTickets;
  final int priceDKK;
  final List<Drink> eligibleDrinks;

  @override
  // use the Equatable package to simplify equality checks between Products
  // if all properties are equal, two Products are considered equal
  List<Object?> get props => [
    title,
    description,
    numberOfTickets,
    priceDKK,
    eligibleDrinks,
  ];
}

// TODO(marfavi): Get products from backend
const products = [
  PurchasableTicketGroup(
    title: 'Fancy',
    description:
        'Iced or dirty (with espresso) versions of Large drinks. '
        'Add syrup at no extra cost.',
    eligibleDrinks: [
      Drink(id: 1, name: 'Iced Latte'),
      Drink(id: 2, name: 'Iced Matcha'),
      Drink(id: 3, name: 'Dirty Cocoa'),
      Drink(id: 4, name: 'Dirty Chai'),
      Drink(id: 5, name: 'Dirty Matcha'),
    ],
    numberOfTickets: 5,
    priceDKK: 150,
  ),
  PurchasableTicketGroup(
    title: 'Large',
    description: 'Hot drinks served in a large cup size.',
    eligibleDrinks: [
      Drink(id: 6, name: 'Caffe Latte'),
      Drink(id: 7, name: 'Hot Cocoa'),
      Drink(id: 8, name: 'Chai Latte'),
      Drink(id: 9, name: 'Matcha Latte'),
    ],
    numberOfTickets: 5,
    priceDKK: 100,
  ),
  PurchasableTicketGroup(
    title: 'Small',
    description: 'Hot drinks served in a small cup size.',
    eligibleDrinks: [
      Drink(id: 10, name: 'Cappuccino'),
      Drink(id: 11, name: 'Americano'),
      Drink(id: 12, name: 'Cortado'),
      Drink(id: 13, name: 'Espresso'),
    ],
    numberOfTickets: 5,
    priceDKK: 50,
  ),
  PurchasableTicketGroup(
    title: 'Filter',
    description:
        'Used for filter coffee brewed with fresh ground coffee. '
        'Add milk at no extra cost.',
    eligibleDrinks: [
      Drink(id: 14, name: 'Filter Coffee'),
      Drink(id: 15, name: 'Iced Filter Coffee'),
    ],
    numberOfTickets: 10,
    priceDKK: 110,
  ),
  PurchasableTicketGroup(
    title: 'Tea',
    description:
        'Our wide variety of tea is perfect for any occasion. '
        'Add milk at no extra cost.',
    numberOfTickets: 10,
    priceDKK: 100,
    eligibleDrinks: [
      Drink(id: 16, name: 'Tea'),
    ],
  ),
];
