import 'package:equatable/equatable.dart';

class SuccessfulPurchase extends Equatable {
  const SuccessfulPurchase({
    required this.ticketName,
    required this.amountOfTickets,
  });

  final String ticketName;
  final int amountOfTickets;

  @override
  List<Object?> get props => [ticketName, amountOfTickets];
}
