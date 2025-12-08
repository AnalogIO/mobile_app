import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.title,
    required this.description,
    required this.noTickets,
    required this.priceDKK,
    this.eligibleMenuItems,
  });

  final String title;
  final String description;
  final List<String>? eligibleMenuItems;
  final int noTickets;
  final int priceDKK;

  @override
  List<Object?> get props => [
    title,
    description,
    eligibleMenuItems,
    noTickets,
    priceDKK,
  ];
}
