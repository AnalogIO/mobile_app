import 'dart:convert';

import 'package:cafe_analog_app/core/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the most recently selected drink per ticket group.
class RememberedTicketDrinkLocalStore {
  const RememberedTicketDrinkLocalStore({
    required this._store,
  });

  final SharedPreferencesWithCache _store;

  static const storageKey = 'ticket_last_selected_drink_by_ticket_group';

  TaskEither<Failure, Unit> setLastSelectedDrinkId({
    required int ticketGroupId,
    required int drinkId,
  }) {
    return TaskEither.tryCatch(
      () async {
        final entries = _readEntries();
        entries['$ticketGroupId'] = drinkId;
        await _store.setString(storageKey, json.encode(entries));
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }

  int? getLastSelectedDrinkId({required int ticketGroupId}) {
    final entries = _readEntries();
    final value = entries['$ticketGroupId'];
    return switch (value) {
      final int id => id,
      final num id => id.toInt(),
      _ => null,
    };
  }

  TaskEither<Failure, Unit> clear() {
    return TaskEither.tryCatch(
      () async {
        await _store.remove(storageKey);
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }

  Map<String, dynamic> _readEntries() {
    final raw = _store.getString(storageKey);
    if (raw == null || raw.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = json.decode(raw);
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }
}
