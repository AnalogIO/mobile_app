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
