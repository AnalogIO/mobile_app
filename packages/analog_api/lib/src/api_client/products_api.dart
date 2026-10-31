// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i7;

import 'package:analog_api/src/model/add_product_request.dart' as _i12;
import 'package:analog_api/src/model/product_response.dart' as _i14;
import 'package:analog_api/src/model/update_product_request.dart' as _i15;
import 'package:analog_api/src/operation/products_add_product.dart' as _i3;
import 'package:analog_api/src/operation/products_get_all_products.dart' as _i6;
import 'package:analog_api/src/operation/products_get_product.dart' as _i4;
import 'package:analog_api/src/operation/products_get_products.dart' as _i2;
import 'package:analog_api/src/operation/products_update_product.dart' as _i5;
import 'package:analog_api/src/response_wrapper/products_add_product_response.dart'
    as _i11;
import 'package:analog_api/src/response_wrapper/products_get_product_response.dart'
    as _i13;
import 'package:analog_api/src/response_wrapper/products_get_products_response.dart'
    as _i9;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i10;
import 'package:tonik_util/tonik_util.dart' as _i8;

class ProductsApi {
  ProductsApi(_i1.Server server)
    : _productsGetProducts = _i2.ProductsGetProducts(
        server.baseUrl,
        () => server.dio,
      ),
      _productsAddProduct = _i3.ProductsAddProduct(
        server.baseUrl,
        () => server.dio,
      ),
      _productsGetProduct = _i4.ProductsGetProduct(
        server.baseUrl,
        () => server.dio,
      ),
      _productsUpdateProduct = _i5.ProductsUpdateProduct(
        server.baseUrl,
        () => server.dio,
      ),
      _productsGetAllProducts = _i6.ProductsGetAllProducts(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.ProductsGetProducts _productsGetProducts;

  final _i3.ProductsAddProduct _productsAddProduct;

  final _i4.ProductsGetProduct _productsGetProduct;

  final _i5.ProductsUpdateProduct _productsUpdateProduct;

  final _i6.ProductsGetAllProducts _productsGetAllProducts;

  /// Returns a list of available products based on a account's user group.
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<_i9.ProductsGetProductsResponse, _i10.Response<_i7.Object?>>
  >
  productsGetProducts({_i8.TonikCancellation? cancellation}) async =>
      this._productsGetProducts(cancellation: cancellation);

  /// Adds a new product
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<_i11.ProductsAddProductResponse, _i10.Response<_i7.Object?>>
  >
  productsAddProduct({
    required _i12.AddProductRequest body,
    _i8.TonikCancellation? cancellation,
  }) async => this._productsAddProduct(body: body, cancellation: cancellation);

  /// Returns a product with the specified id
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<_i13.ProductsGetProductResponse, _i10.Response<_i7.Object?>>
  >
  productsGetProduct({
    required _i7.int id,
    _i8.TonikCancellation? cancellation,
  }) async => this._productsGetProduct(id: id, cancellation: cancellation);

  /// Updates a product with the specified changes.
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<_i8.TonikResult<_i14.ProductResponse, _i10.Response<_i7.Object?>>>
  productsUpdateProduct({
    required _i15.UpdateProductRequest body,
    required _i7.int id,
    _i8.TonikCancellation? cancellation,
  }) async => this._productsUpdateProduct(
    body: body,
    id: id,
    cancellation: cancellation,
  );

  /// Returns a list of all products
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<_i7.List<_i14.ProductResponse>, _i10.Response<_i7.Object?>>
  >
  productsGetAllProducts({_i8.TonikCancellation? cancellation}) async =>
      this._productsGetAllProducts(cancellation: cancellation);
}
