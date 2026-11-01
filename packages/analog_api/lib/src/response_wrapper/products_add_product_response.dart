// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/product_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class ProductsAddProductResponse {
  const ProductsAddProductResponse();
}

@_i1.immutable
class ProductsAddProductResponse201 extends ProductsAddProductResponse {
  const ProductsAddProductResponse201({required this.body});

  final _i2.ProductResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProductsAddProductResponse201 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class ProductsAddProductResponse200 extends ProductsAddProductResponse {
  const ProductsAddProductResponse200();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProductsAddProductResponse200;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
