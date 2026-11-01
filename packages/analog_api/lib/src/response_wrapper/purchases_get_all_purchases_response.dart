// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/simple_purchase_response.dart' as _i3;
import 'package:collection/collection.dart' as _i4;
import 'package:meta/meta.dart' as _i1;

sealed class PurchasesGetAllPurchasesResponse {
  const PurchasesGetAllPurchasesResponse();
}

@_i1.immutable
class PurchasesGetAllPurchasesResponse200
    extends PurchasesGetAllPurchasesResponse {
  const PurchasesGetAllPurchasesResponse200({required this.body});

  final _i2.List<_i3.SimplePurchaseResponse> body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    const _$deepEquals = _i4.DeepCollectionEquality();
    return other is PurchasesGetAllPurchasesResponse200 &&
        _$deepEquals.equals(other.body, this.body);
  }

  @_i2.override
  _i2.int get hashCode {
    const deepEquals = _i4.DeepCollectionEquality();
    return deepEquals.hash(this.body);
  }
}

@_i1.immutable
class PurchasesGetAllPurchasesResponse401
    extends PurchasesGetAllPurchasesResponse {
  const PurchasesGetAllPurchasesResponse401();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is PurchasesGetAllPurchasesResponse401;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class PurchasesGetAllPurchasesResponseDefault
    extends PurchasesGetAllPurchasesResponse {
  const PurchasesGetAllPurchasesResponseDefault();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is PurchasesGetAllPurchasesResponseDefault;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}
