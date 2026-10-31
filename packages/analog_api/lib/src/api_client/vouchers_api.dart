// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i4;

import 'package:analog_api/src/model/issue_voucher_request.dart' as _i8;
import 'package:analog_api/src/operation/vouchers_issue_vouchers.dart' as _i2;
import 'package:analog_api/src/operation/vouchers_redeem_voucher.dart' as _i3;
import 'package:analog_api/src/response_wrapper/vouchers_issue_vouchers_response.dart'
    as _i6;
import 'package:analog_api/src/response_wrapper/vouchers_redeem_voucher_response.dart'
    as _i9;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i7;
import 'package:tonik_util/tonik_util.dart' as _i5;

class VouchersApi {
  VouchersApi(_i1.Server server)
    : _vouchersIssueVouchers = _i2.VouchersIssueVouchers(
        server.baseUrl,
        () => server.dio,
      ),
      _vouchersRedeemVoucher = _i3.VouchersRedeemVoucher(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.VouchersIssueVouchers _vouchersIssueVouchers;

  final _i3.VouchersRedeemVoucher _vouchersRedeemVoucher;

  /// Issue voucher codes, that can later be redeemed
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i4.Future<
    _i5.TonikResult<
      _i6.VouchersIssueVouchersResponse,
      _i7.Response<_i4.Object?>
    >
  >
  vouchersIssueVouchers({
    required _i8.IssueVoucherRequest body,
    _i5.TonikCancellation? cancellation,
  }) async =>
      this._vouchersIssueVouchers(body: body, cancellation: cancellation);

  /// Redeems the voucher supplied as parameter in the path
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i4.Future<
    _i5.TonikResult<
      _i9.VouchersRedeemVoucherResponse,
      _i7.Response<_i4.Object?>
    >
  >
  vouchersRedeemVoucher({
    required _i4.String voucherCode,
    _i5.TonikCancellation? cancellation,
  }) async => this._vouchersRedeemVoucher(
    voucherCode: voucherCode,
    cancellation: cancellation,
  );
}
