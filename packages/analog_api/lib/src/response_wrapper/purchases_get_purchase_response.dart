// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/message_response_dto.dart' as _i4;
import 'package:analog_api/src/model/single_purchase_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class PurchasesGetPurchaseResponse {
  const PurchasesGetPurchaseResponse();
}

@_i1.immutable
class PurchasesGetPurchaseResponse200 extends PurchasesGetPurchaseResponse {
  const PurchasesGetPurchaseResponse200({required this.body});

  final _i2.SinglePurchaseResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesGetPurchaseResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class PurchasesGetPurchaseResponse401 extends PurchasesGetPurchaseResponse {
  const PurchasesGetPurchaseResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesGetPurchaseResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class PurchasesGetPurchaseResponse404 extends PurchasesGetPurchaseResponse {
  const PurchasesGetPurchaseResponse404({required this.body});

  final _i4.MessageResponseDto body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesGetPurchaseResponse404 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}
