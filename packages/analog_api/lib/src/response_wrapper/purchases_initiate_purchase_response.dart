// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/initiate_purchase_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class PurchasesInitiatePurchaseResponse {
  const PurchasesInitiatePurchaseResponse();
}

@_i1.immutable
class PurchasesInitiatePurchaseResponse200
    extends PurchasesInitiatePurchaseResponse {
  const PurchasesInitiatePurchaseResponse200({required this.body});

  final _i2.InitiatePurchaseResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesInitiatePurchaseResponse200 &&
        other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class PurchasesInitiatePurchaseResponse401
    extends PurchasesInitiatePurchaseResponse {
  const PurchasesInitiatePurchaseResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesInitiatePurchaseResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class PurchasesInitiatePurchaseResponse403
    extends PurchasesInitiatePurchaseResponse {
  const PurchasesInitiatePurchaseResponse403();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchasesInitiatePurchaseResponse403;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
