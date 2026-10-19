import 'dart:async';

import 'package:cafe_analog_app/features/login/presentation/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Breaks the dependency cycle between the HTTP layer and the auth cubit.
///
/// [ChopperClient] (that contains [TokenRefreshAuthenticator]) is wired up in
/// a [RepositoryProvider] that runs before the [BlocProvider] for [AuthCubit].
/// This means the authenticator is constructed before a cubit instance exists,
/// so it cannot receive the cubit directly.
///
/// Instead, both are given this shared handle. Once the [BlocProvider] creates
/// [AuthCubit] it immediately calls [bind], after which any call to [logOut]
/// (e.g. when token refresh fails and the user must be signed out) is
/// forwarded to the live cubit. The internal [Completer] guarantees that
/// calls arriving before [bind] has run are safely queued rather than dropped.
class AuthCubitHandle {
  final _completer = Completer<AuthCubit>();
  AuthCubit? _cubit;

  void bind(AuthCubit cubit) {
    _cubit = cubit;
    if (!_completer.isCompleted) {
      _completer.complete(cubit);
    }
  }

  Future<void> logOut() async {
    final cubit = _cubit ?? await _completer.future;
    await cubit.logOut();
  }
}
