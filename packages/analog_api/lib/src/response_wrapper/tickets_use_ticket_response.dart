// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i4;
import 'package:analog_api/src/model/used_ticket_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class TicketsUseTicketResponse {
  const TicketsUseTicketResponse();
}

@_i1.immutable
class TicketsUseTicketResponse200 extends TicketsUseTicketResponse {
  const TicketsUseTicketResponse200({required this.body});

  final _i2.UsedTicketResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is TicketsUseTicketResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class TicketsUseTicketResponse401 extends TicketsUseTicketResponse {
  const TicketsUseTicketResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is TicketsUseTicketResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class TicketsUseTicketResponse403 extends TicketsUseTicketResponse {
  const TicketsUseTicketResponse403({required this.body});

  final _i4.ApiError body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is TicketsUseTicketResponse403 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class TicketsUseTicketResponse404 extends TicketsUseTicketResponse {
  const TicketsUseTicketResponse404({required this.body});

  final _i4.ApiError body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is TicketsUseTicketResponse404 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}
