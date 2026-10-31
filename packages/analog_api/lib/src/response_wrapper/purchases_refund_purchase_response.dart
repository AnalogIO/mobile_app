// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/simple_purchase_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class PurchasesRefundPurchaseResponse {
  const PurchasesRefundPurchaseResponse();
}

@_i1.immutable
class PurchasesRefundPurchaseResponse200
    extends PurchasesRefundPurchaseResponse {
  const PurchasesRefundPurchaseResponse200({required this.body});

  final _i2.SimplePurchaseResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesRefundPurchaseResponse200 &&
        other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class PurchasesRefundPurchaseResponse401
    extends PurchasesRefundPurchaseResponse {
  const PurchasesRefundPurchaseResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesRefundPurchaseResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class PurchasesRefundPurchaseResponse403
    extends PurchasesRefundPurchaseResponse {
  const PurchasesRefundPurchaseResponse403();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesRefundPurchaseResponse403;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
