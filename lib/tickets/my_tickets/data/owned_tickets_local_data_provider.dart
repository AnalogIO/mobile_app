import 'dart:convert';

import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnedTicketsLocalDataProvider {
  const OwnedTicketsLocalDataProvider({
    required SharedPreferencesWithCache localStorage,
  }) : _localStorage = localStorage;

  final SharedPreferencesWithCache _localStorage;

  static const storageKey = 'tickets';

  TaskEither<Failure, Unit> set(List<OwnedTicket> tickets) {
    return TaskEither.tryCatch(
      () async {
        final rawList = tickets.map((ticket) => ticket.toJson()).toList();
        final raw = json.encode(rawList);
        await _localStorage.setString(storageKey, raw);
        return unit;
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }

  TaskEither<Failure, List<OwnedTicket>> get() {
    return TaskEither.tryCatch(
      () async {
        final raw = _localStorage.getString(storageKey);
        if (raw == null || raw.isEmpty) {
          throw Exception('No cached tickets found');
        }
        final jsonList = json.decode(raw) as List<dynamic>;
        return jsonList
            .map((e) => OwnedTicket.fromJson(e as Map<String, dynamic>))
            .toList(growable: false);
      },
      (error, _) => LocalStorageFailure(error.toString()),
    );
  }
}
