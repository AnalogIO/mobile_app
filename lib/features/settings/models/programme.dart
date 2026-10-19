import 'package:equatable/equatable.dart';

/// A study programme (occupation) a user can belong to.
class Programme extends Equatable {
  const new({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  final int id;
  final String shortName;
  final String fullName;

  @override
  List<Object?> get props => [id, shortName, fullName];
}
