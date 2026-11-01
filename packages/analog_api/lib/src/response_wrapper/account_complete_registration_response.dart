// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i4;
import 'package:analog_api/src/model/user_login_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class AccountCompleteRegistrationResponse {
  const AccountCompleteRegistrationResponse();
}

@_i1.immutable
class AccountCompleteRegistrationResponse200
    extends AccountCompleteRegistrationResponse {
  const AccountCompleteRegistrationResponse200({required this.body});

  final _i2.UserLoginResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountCompleteRegistrationResponse200 &&
        other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountCompleteRegistrationResponse400
    extends AccountCompleteRegistrationResponse {
  const AccountCompleteRegistrationResponse400({required this.body});

  final _i4.ApiError body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountCompleteRegistrationResponse400 &&
        other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountCompleteRegistrationResponse401
    extends AccountCompleteRegistrationResponse {
  const AccountCompleteRegistrationResponse401({required this.body});

  final _i4.ApiError body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountCompleteRegistrationResponse401 &&
        other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}
