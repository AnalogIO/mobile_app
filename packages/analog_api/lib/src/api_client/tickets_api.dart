// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i5;

import 'package:analog_api/src/model/use_ticket_request.dart' as _i10;
import 'package:analog_api/src/operation/tickets_get.dart' as _i2;
import 'package:analog_api/src/operation/tickets_get_grouped_owned_tickets.dart'
    as _i4;
import 'package:analog_api/src/operation/tickets_use_ticket.dart' as _i3;
import 'package:analog_api/src/response_wrapper/tickets_get_grouped_owned_tickets_response.dart'
    as _i11;
import 'package:analog_api/src/response_wrapper/tickets_get_response.dart'
    as _i7;
import 'package:analog_api/src/response_wrapper/tickets_use_ticket_response.dart'
    as _i9;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i8;
import 'package:tonik_util/tonik_util.dart' as _i6;

class TicketsApi {
  TicketsApi(_i1.Server server)
    : _ticketsGet = _i2.TicketsGet(server.baseUrl, () => server.dio),
      _ticketsUseTicket = _i3.TicketsUseTicket(
        server.baseUrl,
        () => server.dio,
      ),
      _ticketsGetGroupedOwnedTickets = _i4.TicketsGetGroupedOwnedTickets(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.TicketsGet _ticketsGet;

  final _i3.TicketsUseTicket _ticketsUseTicket;

  final _i4.TicketsGetGroupedOwnedTickets _ticketsGetGroupedOwnedTickets;

  /// Returns a list of tickets
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i5.Future<_i6.TonikResult<_i7.TicketsGetResponse, _i8.Response<_i5.Object?>>>
  ticketsGet({
    _i5.bool? includeUsed,
    _i6.TonikCancellation? cancellation,
  }) async =>
      this._ticketsGet(includeUsed: includeUsed, cancellation: cancellation);

  /// Uses a ticket (for the given product) on the given menu item
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i5.Future<
    _i6.TonikResult<_i9.TicketsUseTicketResponse, _i8.Response<_i5.Object?>>
  >
  ticketsUseTicket({
    required _i10.UseTicketRequest body,
    _i6.TonikCancellation? cancellation,
  }) async => this._ticketsUseTicket(body: body, cancellation: cancellation);

  /// Retrieve the owned tickets of the account (grouped)
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i5.Future<
    _i6.TonikResult<
      _i11.TicketsGetGroupedOwnedTicketsResponse,
      _i8.Response<_i5.Object?>
    >
  >
  ticketsGetGroupedOwnedTickets({_i6.TonikCancellation? cancellation}) async =>
      this._ticketsGetGroupedOwnedTickets(cancellation: cancellation);
}
