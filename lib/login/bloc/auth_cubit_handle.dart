import 'dart:async';

import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';

/// Holds a late-bound [AuthCubit] instance for components created earlier.
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
