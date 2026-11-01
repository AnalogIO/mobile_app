// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/message_response_dto.dart' as _i4;
import 'package:analog_api/src/model/user_login_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class AccountAuthenticateResponse {
  const AccountAuthenticateResponse();
}

@_i1.immutable
class AccountAuthenticateResponse200 extends AccountAuthenticateResponse {
  const AccountAuthenticateResponse200({required this.body});

  final _i2.UserLoginResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountAuthenticateResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountAuthenticateResponse404 extends AccountAuthenticateResponse {
  const AccountAuthenticateResponse404({required this.body});

  final _i4.MessageResponseDto body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountAuthenticateResponse404 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountAuthenticateResponseDefault extends AccountAuthenticateResponse {
  const AccountAuthenticateResponseDefault();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountAuthenticateResponseDefault;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
