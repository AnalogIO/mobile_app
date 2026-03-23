import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
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
