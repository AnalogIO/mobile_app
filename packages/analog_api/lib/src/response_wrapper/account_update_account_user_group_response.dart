// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/api_error.dart' as _i3;
import 'package:meta/meta.dart' as _i1;

sealed class AccountUpdateAccountUserGroupResponse {
  const AccountUpdateAccountUserGroupResponse();
}

@_i1.immutable
class AccountUpdateAccountUserGroupResponse204
    extends AccountUpdateAccountUserGroupResponse {
  const AccountUpdateAccountUserGroupResponse204();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountUpdateAccountUserGroupResponse204;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class AccountUpdateAccountUserGroupResponse401
    extends AccountUpdateAccountUserGroupResponse {
  const AccountUpdateAccountUserGroupResponse401({required this.body});

  final _i3.ApiError body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountUpdateAccountUserGroupResponse401 &&
        other.body == this.body;
  }

  @_i2.override
  _i2.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountUpdateAccountUserGroupResponse404
    extends AccountUpdateAccountUserGroupResponse {
  const AccountUpdateAccountUserGroupResponse404({required this.body});

  final _i3.ApiError body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountUpdateAccountUserGroupResponse404 &&
        other.body == this.body;
  }

  @_i2.override
  _i2.int get hashCode => this.body.hashCode;
}
