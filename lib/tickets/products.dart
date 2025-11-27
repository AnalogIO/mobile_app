import 'package:cafe_analog_app/tickets/product.dart';

const products = [
  Product(
    title: 'Fancy',
    description:
        'Iced or dirty (with espresso) versions of Large drinks. '
        'Add syrup at no extra cost.',
    eligibleMenuItems: [
      'Iced Latte',
      'Iced Matcha',
      'Dirty Cocoa',
      'Dirty Chai',
      'Dirty Matcha',
    ],
    noTickets: 5,
    priceDKK: 150,
  ),
  Product(
    title: 'Large',
    description: 'Hot drinks served in a large cup size.',
    eligibleMenuItems: [
      'Caffe Latte',
      'Hot Cocoa',
      'Chai Latte',
      'Matcha Latte',
    ],
    noTickets: 5,
    priceDKK: 100,
  ),
  Product(
    title: 'Small',
    description: 'Hot drinks served in a small cup size.',
    eligibleMenuItems: [
      'Cappuccino',
      'Americano',
      'Cortado',
      'Espresso',
    ],
    noTickets: 5,
    priceDKK: 50,
  ),
  Product(
    title: 'Filter',
    description:
        'Used for filter coffee brewed with fresh ground coffee. '
        'Add milk at no extra cost.',
    eligibleMenuItems: ['Filter Coffee', 'Iced Filter Coffee'],
    noTickets: 10,
    priceDKK: 110,
  ),
  Product(
    title: 'Tea',
    description:
        'Our wide variety of tea is perfect for any occasion. '
        'Add milk at no extra cost.',
    noTickets: 10,
    priceDKK: 100,
  ),
];
