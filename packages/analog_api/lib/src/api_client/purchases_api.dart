// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i7;

import 'package:analog_api/src/model/initiate_purchase_request.dart' as _i12;
import 'package:analog_api/src/operation/purchases_get_all_purchases.dart'
    as _i2;
import 'package:analog_api/src/operation/purchases_get_all_purchases_for_user.dart'
    as _i4;
import 'package:analog_api/src/operation/purchases_get_purchase.dart' as _i5;
import 'package:analog_api/src/operation/purchases_initiate_purchase.dart'
    as _i3;
import 'package:analog_api/src/operation/purchases_refund_purchase.dart' as _i6;
import 'package:analog_api/src/response_wrapper/purchases_get_all_purchases_for_user_response.dart'
    as _i13;
import 'package:analog_api/src/response_wrapper/purchases_get_all_purchases_response.dart'
    as _i9;
import 'package:analog_api/src/response_wrapper/purchases_get_purchase_response.dart'
    as _i14;
import 'package:analog_api/src/response_wrapper/purchases_initiate_purchase_response.dart'
    as _i11;
import 'package:analog_api/src/response_wrapper/purchases_refund_purchase_response.dart'
    as _i15;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i10;
import 'package:tonik_util/tonik_util.dart' as _i8;

class PurchasesApi {
  PurchasesApi(_i1.Server server)
    : _purchasesGetAllPurchases = _i2.PurchasesGetAllPurchases(
        server.baseUrl,
        () => server.dio,
      ),
      _purchasesInitiatePurchase = _i3.PurchasesInitiatePurchase(
        server.baseUrl,
        () => server.dio,
      ),
      _purchasesGetAllPurchasesForUser = _i4.PurchasesGetAllPurchasesForUser(
        server.baseUrl,
        () => server.dio,
      ),
      _purchasesGetPurchase = _i5.PurchasesGetPurchase(
        server.baseUrl,
        () => server.dio,
      ),
      _purchasesRefundPurchase = _i6.PurchasesRefundPurchase(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.PurchasesGetAllPurchases _purchasesGetAllPurchases;

  final _i3.PurchasesInitiatePurchase _purchasesInitiatePurchase;

  final _i4.PurchasesGetAllPurchasesForUser _purchasesGetAllPurchasesForUser;

  final _i5.PurchasesGetPurchase _purchasesGetPurchase;

  final _i6.PurchasesRefundPurchase _purchasesRefundPurchase;

  /// Get all purchases
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<
      _i9.PurchasesGetAllPurchasesResponse,
      _i10.Response<_i7.Object?>
    >
  >
  purchasesGetAllPurchases({_i8.TonikCancellation? cancellation}) async =>
      this._purchasesGetAllPurchases(cancellation: cancellation);

  /// Initiate a new payment.
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<
      _i11.PurchasesInitiatePurchaseResponse,
      _i10.Response<_i7.Object?>
    >
  >
  purchasesInitiatePurchase({
    required _i12.InitiatePurchaseRequest body,
    _i8.TonikCancellation? cancellation,
  }) async =>
      this._purchasesInitiatePurchase(body: body, cancellation: cancellation);

  /// Get all purchases for a user
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<
      _i13.PurchasesGetAllPurchasesForUserResponse,
      _i10.Response<_i7.Object?>
    >
  >
  purchasesGetAllPurchasesForUser({
    required _i7.int userId,
    _i8.TonikCancellation? cancellation,
  }) async => this._purchasesGetAllPurchasesForUser(
    userId: userId,
    cancellation: cancellation,
  );

  /// Get purchase
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<
      _i14.PurchasesGetPurchaseResponse,
      _i10.Response<_i7.Object?>
    >
  >
  purchasesGetPurchase({
    required _i7.int id,
    _i8.TonikCancellation? cancellation,
  }) async => this._purchasesGetPurchase(id: id, cancellation: cancellation);

  /// Refunds a payment
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i7.Future<
    _i8.TonikResult<
      _i15.PurchasesRefundPurchaseResponse,
      _i10.Response<_i7.Object?>
    >
  >
  purchasesRefundPurchase({
    required _i7.int id,
    _i8.TonikCancellation? cancellation,
  }) async => this._purchasesRefundPurchase(id: id, cancellation: cancellation);
}
