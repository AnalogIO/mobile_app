import 'package:equatable/equatable.dart';

/// A drink that can be redeemed with a ticket.
class Drink extends Equatable {
  const Drink({required this.id, required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
