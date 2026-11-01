// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/service_health_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class HealthHealthcheckResponse {
  const HealthHealthcheckResponse();
}

@_i1.immutable
class HealthHealthcheckResponse200 extends HealthHealthcheckResponse {
  const HealthHealthcheckResponse200({required this.body});

  final _i2.ServiceHealthResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is HealthHealthcheckResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class HealthHealthcheckResponse503 extends HealthHealthcheckResponse {
  const HealthHealthcheckResponse503({required this.body});

  final _i2.ServiceHealthResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is HealthHealthcheckResponse503 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class HealthHealthcheckResponseDefault extends HealthHealthcheckResponse {
  const HealthHealthcheckResponseDefault();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is HealthHealthcheckResponseDefault;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
