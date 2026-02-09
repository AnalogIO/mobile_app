import 'dart:convert';

import 'package:cafe_analog_app/core/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketOrderDataProvider {
  const TicketOrderDataProvider({
    required SharedPreferencesWithCache localStorage,
  }) : _localStorage = localStorage;

  final SharedPreferencesWithCache _localStorage;

  static const String storageKey = 'tickets_preferred_order';

  TaskEither<Failure, Unit> set(List<int> order) {
    return TaskEither.tryCatch(
      () async {
        final raw = json.encode(order);
        await _localStorage.setString(storageKey, raw);
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }

  TaskEither<Failure, List<int>> get() {
    return TaskEither.tryCatch(
      () async {
        final raw = _localStorage.getString(storageKey);
        if (raw == null || raw.isEmpty) {
          throw Exception('No cached ticket order found');
        }
        final jsonList = json.decode(raw) as List<dynamic>;
        return jsonList.map((e) => e as int).toList(growable: false);
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }
}
