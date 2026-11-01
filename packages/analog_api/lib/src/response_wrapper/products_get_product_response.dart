// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i4;
import 'package:analog_api/src/model/product_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class ProductsGetProductResponse {
  const ProductsGetProductResponse();
}

@_i1.immutable
class ProductsGetProductResponse200 extends ProductsGetProductResponse {
  const ProductsGetProductResponse200({required this.body});

  final _i2.ProductResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProductsGetProductResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class ProductsGetProductResponse401 extends ProductsGetProductResponse {
  const ProductsGetProductResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProductsGetProductResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class ProductsGetProductResponse404 extends ProductsGetProductResponse {
  const ProductsGetProductResponse404({required this.body});

  final _i4.ApiError body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProductsGetProductResponse404 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class ProductsGetProductResponse403 extends ProductsGetProductResponse {
  const ProductsGetProductResponse403();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProductsGetProductResponse403;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
