// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/email_exists_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class AccountEmailExistsResponse {
  const AccountEmailExistsResponse();
}

@_i1.immutable
class AccountEmailExistsResponse200 extends AccountEmailExistsResponse {
  const AccountEmailExistsResponse200({required this.body});

  final _i2.EmailExistsResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountEmailExistsResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountEmailExistsResponse401 extends AccountEmailExistsResponse {
  const AccountEmailExistsResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountEmailExistsResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
