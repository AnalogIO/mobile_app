import 'package:equatable/equatable.dart';

class OwnedTicket extends Equatable {
  const OwnedTicket({
    required this.productId,
    required this.ticketName,
    required this.ticketsLeft,
    required this.backgroundImagePath,
  });

  // FIXME(marfavi): Use json_serializable instead?
  factory OwnedTicket.fromJson(Map<String, dynamic> json) {
    return OwnedTicket(
      productId: json['productId'] as int,
      ticketName: json['ticketName'] as String,
      ticketsLeft: json['ticketsLeft'] as int,
      backgroundImagePath: json['backgroundImagePath'] as String,
    );
  }

  final int productId;
  final String ticketName;
  final int ticketsLeft;
  final String backgroundImagePath;

  bool get isDepleted => ticketsLeft <= 0;

  /// Returns a copy of this ticket with [ticketsLeft] set to 0,
  /// indicating that the ticket is depleted.
  OwnedTicket asDepleted() => OwnedTicket(
    productId: productId,
    ticketName: ticketName,
    ticketsLeft: 0,
    backgroundImagePath: backgroundImagePath,
  );

  @override
  List<Object?> get props => [
    productId,
    ticketName,
    ticketsLeft,
    backgroundImagePath,
  ];

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'ticketName': ticketName,
    'ticketsLeft': ticketsLeft,
    'backgroundImagePath': backgroundImagePath,
  };
}
