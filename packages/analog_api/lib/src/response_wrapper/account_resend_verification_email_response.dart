// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/api_error.dart' as _i3;
import 'package:meta/meta.dart' as _i1;

sealed class AccountResendVerificationEmailResponse {
  const AccountResendVerificationEmailResponse();
}

@_i1.immutable
class AccountResendVerificationEmailResponse200
    extends AccountResendVerificationEmailResponse {
  const AccountResendVerificationEmailResponse200();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountResendVerificationEmailResponse200;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class AccountResendVerificationEmailResponse404
    extends AccountResendVerificationEmailResponse {
  const AccountResendVerificationEmailResponse404({required this.body});

  final _i3.ApiError body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountResendVerificationEmailResponse404 &&
        other.body == this.body;
  }

  @_i2.override
  _i2.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountResendVerificationEmailResponse409
    extends AccountResendVerificationEmailResponse {
  const AccountResendVerificationEmailResponse409({required this.body});

  final _i3.ApiError body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is AccountResendVerificationEmailResponse409 &&
        other.body == this.body;
  }

  @_i2.override
  _i2.int get hashCode => this.body.hashCode;
}
