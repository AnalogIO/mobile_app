// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/user_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class AccountUpdateResponse {
  const AccountUpdateResponse();
}

@_i1.immutable
class AccountUpdateResponse200 extends AccountUpdateResponse {
  const AccountUpdateResponse200({required this.body});

  final _i2.UserResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountUpdateResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountUpdateResponse401 extends AccountUpdateResponse {
  const AccountUpdateResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountUpdateResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
