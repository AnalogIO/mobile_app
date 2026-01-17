// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffeecard_api_v1.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CoffeecardApiV1 extends CoffeecardApiV1 {
  _$CoffeecardApiV1([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CoffeecardApiV1;

  @override
  Future<Response<MessageResponseDto>> _accountRegisterPost({
    required RegisterDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/Account/register');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MessageResponseDto, MessageResponseDto>($request);
  }

  @override
  Future<Response<TokenDto>> _accountLoginPost({required LoginDto? body}) {
    final Uri $url = Uri.parse('/api/v1/Account/login');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<TokenDto, TokenDto>($request);
  }

  @override
  Future<Response<dynamic>> _accountGet() {
    final Uri $url = Uri.parse('/api/v1/Account');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _accountPut({required UpdateUserDto? body}) {
    final Uri $url = Uri.parse('/api/v1/Account');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MessageResponseDto>> _accountForgotpasswordPost({
    required EmailDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/Account/forgotpassword');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MessageResponseDto, MessageResponseDto>($request);
  }

  @override
  Future<Response<dynamic>> _appConfigGet() {
    final Uri $url = Uri.parse('/api/v1/AppConfig');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CoffeeCardDto>> _coffeeCardsGet() {
    final Uri $url = Uri.parse('/api/v1/CoffeeCards');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<CoffeeCardDto, CoffeeCardDto>($request);
  }

  @override
  Future<Response<dynamic>> _leaderboardGet({int? preset, int? top}) {
    final Uri $url = Uri.parse('/api/v1/Leaderboard');
    final Map<String, dynamic> $params = <String, dynamic>{
      'preset': preset,
      'top': top,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mobilePayInitiatePost({
    required InitiatePurchaseDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/MobilePay/initiate');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mobilePayCompletePost({
    required CompletePurchaseDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/MobilePay/complete');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _pingGet() {
    final Uri $url = Uri.parse('/api/v1/Ping');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ProductDto>>> _productsGet() {
    final Uri $url = Uri.parse('/api/v1/Products');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<ProductDto>, ProductDto>($request);
  }

  @override
  Future<Response<List<ProductDto>>> _productsAppGet() {
    final Uri $url = Uri.parse('/api/v1/Products/app');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<ProductDto>, ProductDto>($request);
  }

  @override
  Future<Response<List<ProgrammeDto>>> _programmesGet() {
    final Uri $url = Uri.parse('/api/v1/Programmes');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<ProgrammeDto>, ProgrammeDto>($request);
  }

  @override
  Future<Response<dynamic>> _purchasesGet() {
    final Uri $url = Uri.parse('/api/v1/Purchases');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PurchaseDto>> _purchasesRedeemvoucherPost({
    String? voucherCode,
  }) {
    final Uri $url = Uri.parse('/api/v1/Purchases/redeemvoucher');
    final Map<String, dynamic> $params = <String, dynamic>{
      'voucherCode': voucherCode,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PurchaseDto, PurchaseDto>($request);
  }

  @override
  Future<Response<dynamic>> _purchasesIssueproductPost({
    required IssueProductDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/Purchases/issueproduct');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TicketDto>>> _ticketsGet({bool? used}) {
    final Uri $url = Uri.parse('/api/v1/Tickets');
    final Map<String, dynamic> $params = <String, dynamic>{'used': used};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<TicketDto>, TicketDto>($request);
  }

  @override
  Future<Response<List<TicketDto>>> _ticketsUseMultiplePost({
    required UseMultipleTicketDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/Tickets/useMultiple');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<List<TicketDto>, TicketDto>($request);
  }

  @override
  Future<Response<UsedTicketResponse>> _ticketsUsePost({
    required UseTicketDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/Tickets/use');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<UsedTicketResponse, UsedTicketResponse>($request);
  }
}
