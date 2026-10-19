import 'dart:convert';

import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnedTicketsLocalStore {
  const OwnedTicketsLocalStore({required this._store});

  final SharedPreferencesWithCache _store;

  static const storageKey = 'tickets';

  TaskEither<Failure, Unit> set(List<OwnedTicketGroup> tickets) {
    return TaskEither.tryCatch(
      () async {
        final rawList = tickets.map((ticket) => ticket.toJson()).toList();
        final raw = json.encode(rawList);
        await _store.setString(storageKey, raw);
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }

  TaskEither<Failure, List<OwnedTicketGroup>> get() {
    return TaskEither.tryCatch(
      () async {
        final raw = _store.getString(storageKey);
        if (raw == null || raw.isEmpty) {
          throw Exception('No cached tickets found');
        }
        final jsonList = json.decode(raw) as List<dynamic>;
        return jsonList
            .map((e) => OwnedTicketGroup.fromJson(e as Map<String, dynamic>))
            .toList(growable: false);
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }
}
