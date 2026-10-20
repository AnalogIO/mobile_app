import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Clears the user-scoped state that must never leak between accounts.
///
/// This covers both security-sensitive data (the tickets owned by the previous
/// account) and convenience data (remembered drink choices and the profile
/// picture). Product catalogue and drink caches are global and are not cleared.
class UserContextCleaner {
  const new({required this._localStorage});

  final SharedPreferencesWithCache _localStorage;

  /// Clears all user-scoped caches. Safe to call multiple times.
  Future<void> clear() async {
    // Tickets first: the owned-tickets cache drives the "You've run out of ..."
    // cards and must not be shown to the next account.
    await OwnedTicketsLocalStore(store: _localStorage).clear().run();
    await RememberedTicketDrinkLocalStore(store: _localStorage).clear().run();
    await ProfilePictureLocalStore(store: _localStorage).clear().run();
  }
}
