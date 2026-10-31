// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i4;
import 'package:analog_api/src/model/message_response_dto.dart' as _i5;
import 'package:analog_api/src/model/simple_purchase_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class VouchersRedeemVoucherResponse {
  const VouchersRedeemVoucherResponse();
}

@_i1.immutable
class VouchersRedeemVoucherResponse200 extends VouchersRedeemVoucherResponse {
  const VouchersRedeemVoucherResponse200({required this.body});

  final _i2.SimplePurchaseResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is VouchersRedeemVoucherResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class VouchersRedeemVoucherResponse400 extends VouchersRedeemVoucherResponse {
  const VouchersRedeemVoucherResponse400({required this.body});

  final _i4.ApiError body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is VouchersRedeemVoucherResponse400 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class VouchersRedeemVoucherResponse401 extends VouchersRedeemVoucherResponse {
  const VouchersRedeemVoucherResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is VouchersRedeemVoucherResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class VouchersRedeemVoucherResponse404 extends VouchersRedeemVoucherResponse {
  const VouchersRedeemVoucherResponse404({required this.body});

  final _i5.MessageResponseDto body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is VouchersRedeemVoucherResponse404 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}
