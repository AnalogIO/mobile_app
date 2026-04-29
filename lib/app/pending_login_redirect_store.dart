/// Holds the pending redirect URL when a user tries to access a protected route
/// while not logged in. After the user logs in successfully, they can be
/// redirected to the originally intended route.
class PendingLoginRedirectStore {
  String? _pendingRedirect;

  set pendingRedirect(String? redirect) {
    _pendingRedirect = redirect;
  }

  String? get pendingRedirect {
    final redirect = _pendingRedirect;
    _pendingRedirect = null;
    return redirect;
  }
}
