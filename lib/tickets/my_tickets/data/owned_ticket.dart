import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:equatable/equatable.dart';

class OwnedTicket extends Equatable {
  const OwnedTicket({
    required this.productId,
    required this.ticketName,
    required this.ticketsLeft,
    required this.backgroundImagePath,
    required this.eligibleDrinks,
  });

  // FIXME(marfavi): Use json_serializable instead?
  factory OwnedTicket.fromJson(Map<String, dynamic> json) {
    return OwnedTicket(
      productId: json['productId'] as int,
      ticketName: json['ticketName'] as String,
      ticketsLeft: json['ticketsLeft'] as int,
      backgroundImagePath: json['backgroundImagePath'] as String,
      eligibleDrinks: (json['eligibleDrinks'] as List<dynamic>)
          .map((e) => Drink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int productId;
  final String ticketName;
  final int ticketsLeft;
  final String backgroundImagePath;
  final List<Drink> eligibleDrinks;

  bool get isDepleted => ticketsLeft <= 0;

  /// Returns a copy of this ticket with [ticketsLeft] set to 0 and no eligible
  /// drinks, effectively marking the ticket as depleted.
  OwnedTicket asDepleted() => OwnedTicket(
    productId: productId,
    ticketName: ticketName,
    ticketsLeft: 0,
    backgroundImagePath: backgroundImagePath,
    eligibleDrinks: const [],
  );

  @override
  List<Object?> get props => [
    productId,
    ticketName,
    ticketsLeft,
    backgroundImagePath,
    eligibleDrinks,
  ];

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'ticketName': ticketName,
    'ticketsLeft': ticketsLeft,
    'backgroundImagePath': backgroundImagePath,
    'eligibleDrinks': eligibleDrinks.map((e) => e.toJson()).toList(),
  };
}
