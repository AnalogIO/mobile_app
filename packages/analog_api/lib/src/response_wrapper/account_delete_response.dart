// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/api_error.dart' as _i3;
import 'package:meta/meta.dart' as _i1;

sealed class AccountDeleteResponse {
  const AccountDeleteResponse();
}

@_i1.immutable
class AccountDeleteResponse202 extends AccountDeleteResponse {
  const AccountDeleteResponse202();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountDeleteResponse202;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class AccountDeleteResponse401 extends AccountDeleteResponse {
  const AccountDeleteResponse401();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountDeleteResponse401;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class AccountDeleteResponse429 extends AccountDeleteResponse {
  const AccountDeleteResponse429({required this.body});

  final _i3.ApiError body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountDeleteResponse429 && other.body == this.body;
  }

  @_i2.override
  _i2.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountDeleteResponse404 extends AccountDeleteResponse {
  const AccountDeleteResponse404();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountDeleteResponse404;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}
