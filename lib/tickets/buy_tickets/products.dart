import 'package:cafe_analog_app/tickets/buy_tickets/drink.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';

// TODO(marfavi): Get products from backend
const products = [
  Product(
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
  Product(
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
  Product(
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
  Product(
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
  Product(
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
