import 'package:equatable/equatable.dart';

/// Represents the information about a spent ticket,
/// including the drink name, ticket name, and the time it was spent.
class SpentTicketInfo extends Equatable {
  const SpentTicketInfo({
    required this.drinkName,
    required this.ticketName,
    required this.usedAt,
  });

  final String drinkName;
  final String ticketName;
  final DateTime usedAt;

  @override
  List<Object?> get props => [drinkName, ticketName, usedAt];
}
