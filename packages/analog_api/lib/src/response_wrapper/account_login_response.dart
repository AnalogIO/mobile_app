// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:meta/meta.dart' as _i1;

sealed class AccountLoginResponse {
  const AccountLoginResponse();
}

@_i1.immutable
class AccountLoginResponse204 extends AccountLoginResponse {
  const AccountLoginResponse204();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountLoginResponse204;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class AccountLoginResponseDefault extends AccountLoginResponse {
  const AccountLoginResponseDefault();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountLoginResponseDefault;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}
