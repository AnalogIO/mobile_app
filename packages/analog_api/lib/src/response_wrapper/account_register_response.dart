// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/message_response_dto.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class AccountRegisterResponse {
  const AccountRegisterResponse();
}

@_i1.immutable
class AccountRegisterResponse201 extends AccountRegisterResponse {
  const AccountRegisterResponse201({required this.body});

  final _i2.MessageResponseDto body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountRegisterResponse201 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class AccountRegisterResponse409 extends AccountRegisterResponse {
  const AccountRegisterResponse409({required this.body});

  final _i2.MessageResponseDto body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountRegisterResponse409 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}
