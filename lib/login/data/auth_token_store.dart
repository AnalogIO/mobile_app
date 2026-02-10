/// In-memory holder for the current JWT so that the network interceptor
/// can attach it to outgoing requests without reading secure storage.
class AuthTokenStore {
  String? token;
}
