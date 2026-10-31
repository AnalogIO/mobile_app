// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/api_error.dart' as _i5;
import 'package:analog_api/src/model/issue_voucher_response.dart' as _i3;
import 'package:collection/collection.dart' as _i4;
import 'package:meta/meta.dart' as _i1;

sealed class VouchersIssueVouchersResponse {
  const VouchersIssueVouchersResponse();
}

@_i1.immutable
class VouchersIssueVouchersResponse200 extends VouchersIssueVouchersResponse {
  const VouchersIssueVouchersResponse200({required this.body});

  final _i2.List<_i3.IssueVoucherResponse> body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    const _$deepEquals = _i4.DeepCollectionEquality();
    return other is VouchersIssueVouchersResponse200 &&
        _$deepEquals.equals(other.body, this.body);
  }

  @_i2.override
  _i2.int get hashCode {
    const deepEquals = _i4.DeepCollectionEquality();
    return deepEquals.hash(this.body);
  }
}

@_i1.immutable
class VouchersIssueVouchersResponse400 extends VouchersIssueVouchersResponse {
  const VouchersIssueVouchersResponse400({required this.body});

  final _i5.ApiError body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is VouchersIssueVouchersResponse400 && other.body == this.body;
  }

  @_i2.override
  _i2.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class VouchersIssueVouchersResponse401 extends VouchersIssueVouchersResponse {
  const VouchersIssueVouchersResponse401();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is VouchersIssueVouchersResponse401;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class VouchersIssueVouchersResponse403 extends VouchersIssueVouchersResponse {
  const VouchersIssueVouchersResponse403();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is VouchersIssueVouchersResponse403;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}
