import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.title,
    required this.description,
    required this.numberOfTickets,
    required this.priceDKK,
    this.eligibleMenuItems,
  });

  final String title;
  final String description;
  final List<String>? eligibleMenuItems;
  final int numberOfTickets;
  final int priceDKK;

  @override
  // use the Equatable package to simplify equality checks between Products
  // if all properties are equal, two Products are considered equal
  List<Object?> get props => [
    title,
    description,
    eligibleMenuItems,
    numberOfTickets,
    priceDKK,
  ];
}
