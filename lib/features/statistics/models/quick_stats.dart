import 'package:equatable/equatable.dart';

class QuickStats extends Equatable {
  const QuickStats({
    required this.allTimeDrinksConsumed,
    required this.todayDrinksConsumedITU,
    required this.allTimeFavouriteDrink,
    required this.weekDrinksConsumed,
  });

  final int allTimeDrinksConsumed;
  final int todayDrinksConsumedITU;
  final (int count, String drinkName) allTimeFavouriteDrink;
  final int weekDrinksConsumed;

  @override
  List<Object?> get props => [
    allTimeDrinksConsumed,
    todayDrinksConsumedITU,
    allTimeFavouriteDrink,
    weekDrinksConsumed,
  ];
}
