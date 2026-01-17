// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffeecard_api_v2.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CoffeecardApiV2 extends CoffeecardApiV2 {
  _$CoffeecardApiV2([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CoffeecardApiV2;

  @override
  Future<Response<MessageResponseDto>> _accountPost({
    required RegisterAccountRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MessageResponseDto, MessageResponseDto>($request);
  }

  @override
  Future<Response<dynamic>> _accountDelete() {
    final Uri $url = Uri.parse('/api/v2/account');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserResponse>> _accountGet() {
    final Uri $url = Uri.parse('/api/v2/account');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<UserResponse, UserResponse>($request);
  }

  @override
  Future<Response<UserResponse>> _accountPut({
    required UpdateUserRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<UserResponse, UserResponse>($request);
  }

  @override
  Future<Response<EmailExistsResponse>> _accountEmailExistsPost({
    required EmailExistsRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account/email-exists');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<EmailExistsResponse, EmailExistsResponse>($request);
  }

  @override
  Future<Response<dynamic>> _accountIdUserGroupPatch({
    required int? id,
    required UpdateUserGroupRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account/${id}/user-group');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _accountResendVerificationEmailPost({
    required ResendAccountVerificationEmailRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account/resend-verification-email');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserSearchResponse>> _accountSearchGet({
    int? pageNum,
    String? filter,
    int? pageLength,
  }) {
    final Uri $url = Uri.parse('/api/v2/account/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'pageNum': pageNum,
      'filter': filter,
      'pageLength': pageLength,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserSearchResponse, UserSearchResponse>($request);
  }

  @override
  Future<Response<dynamic>> _accountLoginPost({
    required UserLoginRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account/login');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserLoginResponse>> _accountAuthPost({
    required TokenLoginRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/account/auth');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<UserLoginResponse, UserLoginResponse>($request);
  }

  @override
  Future<Response<List<UnusedClipsResponse>>> _statisticsUnusedClipsPost({
    required UnusedClipsRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/statistics/unused-clips');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<List<UnusedClipsResponse>, UnusedClipsResponse>(
      $request,
    );
  }

  @override
  Future<Response<AppConfig>> _appconfigGet() {
    final Uri $url = Uri.parse('/api/v2/appconfig');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AppConfig, AppConfig>($request);
  }

  @override
  Future<Response<String>> _healthPingGet() {
    final Uri $url = Uri.parse('/api/v2/health/ping');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<ServiceHealthResponse>> _healthCheckGet() {
    final Uri $url = Uri.parse('/api/v2/health/check');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<ServiceHealthResponse, ServiceHealthResponse>($request);
  }

  @override
  Future<Response<List<LeaderboardEntry>>> _leaderboardTopGet({
    Object? preset,
    int? top,
  }) {
    final Uri $url = Uri.parse('/api/v2/leaderboard/top');
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
    return client.send<List<LeaderboardEntry>, LeaderboardEntry>($request);
  }

  @override
  Future<Response<LeaderboardEntry>> _leaderboardGet({Object? preset}) {
    final Uri $url = Uri.parse('/api/v2/leaderboard');
    final Map<String, dynamic> $params = <String, dynamic>{'preset': preset};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<LeaderboardEntry, LeaderboardEntry>($request);
  }

  @override
  Future<Response<List<MenuItemResponse>>> _menuitemsGet() {
    final Uri $url = Uri.parse('/api/v2/menuitems');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<MenuItemResponse>, MenuItemResponse>($request);
  }

  @override
  Future<Response<MenuItemResponse>> _menuitemsPost({
    required AddMenuItemRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/menuitems');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MenuItemResponse, MenuItemResponse>($request);
  }

  @override
  Future<Response<MenuItemResponse>> _menuitemsIdPut({
    required int? id,
    required UpdateMenuItemRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/menuitems/${id}');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<MenuItemResponse, MenuItemResponse>($request);
  }

  @override
  Future<Response<ProductResponse>> _productsPost({
    required AddProductRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/products');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<ProductResponse, ProductResponse>($request);
  }

  @override
  Future<Response<List<ProductResponse>>> _productsGet() {
    final Uri $url = Uri.parse('/api/v2/products');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<ProductResponse>, ProductResponse>($request);
  }

  @override
  Future<Response<ProductResponse>> _productsIdPut({
    required int? id,
    required UpdateProductRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/products/${id}');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<ProductResponse, ProductResponse>($request);
  }

  @override
  Future<Response<ProductResponse>> _productsIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/v2/products/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<ProductResponse, ProductResponse>($request);
  }

  @override
  Future<Response<List<ProductResponse>>> _productsAllGet() {
    final Uri $url = Uri.parse('/api/v2/products/all');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<ProductResponse>, ProductResponse>($request);
  }

  @override
  Future<Response<List<SimplePurchaseResponse>>> _purchasesGet() {
    final Uri $url = Uri.parse('/api/v2/purchases');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<SimplePurchaseResponse>, SimplePurchaseResponse>(
      $request,
    );
  }

  @override
  Future<Response<InitiatePurchaseResponse>> _purchasesPost({
    required InitiatePurchaseRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/purchases');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<InitiatePurchaseResponse, InitiatePurchaseResponse>(
      $request,
    );
  }

  @override
  Future<Response<List<SimplePurchaseResponse>>> _purchasesUserUserIdGet({
    required int? userId,
  }) {
    final Uri $url = Uri.parse('/api/v2/purchases/user/${userId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<SimplePurchaseResponse>, SimplePurchaseResponse>(
      $request,
    );
  }

  @override
  Future<Response<SinglePurchaseResponse>> _purchasesIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/v2/purchases/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<SinglePurchaseResponse, SinglePurchaseResponse>(
      $request,
    );
  }

  @override
  Future<Response<SimplePurchaseResponse>> _purchasesIdRefundPut({
    required int? id,
  }) {
    final Uri $url = Uri.parse('/api/v2/purchases/${id}/refund');
    final Request $request = Request('PUT', $url, client.baseUrl);
    return client.send<SimplePurchaseResponse, SimplePurchaseResponse>(
      $request,
    );
  }

  @override
  Future<Response<List<TicketResponse>>> _ticketsGet({bool? includeUsed}) {
    final Uri $url = Uri.parse('/api/v2/tickets');
    final Map<String, dynamic> $params = <String, dynamic>{
      'includeUsed': includeUsed,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<TicketResponse>, TicketResponse>($request);
  }

  @override
  Future<Response<UsedTicketResponse>> _ticketsUsePost({
    required UseTicketRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/tickets/use');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<UsedTicketResponse, UsedTicketResponse>($request);
  }

  @override
  Future<Response<List<IssueVoucherResponse>>> _vouchersIssueVouchersPost({
    required IssueVoucherRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/vouchers/issue-vouchers');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<List<IssueVoucherResponse>, IssueVoucherResponse>(
      $request,
    );
  }

  @override
  Future<Response<SimplePurchaseResponse>> _vouchersVoucherCodeRedeemPost({
    required String? voucherCode,
  }) {
    final Uri $url = Uri.parse('/api/v2/vouchers/${voucherCode}/redeem');
    final Request $request = Request('POST', $url, client.baseUrl);
    return client.send<SimplePurchaseResponse, SimplePurchaseResponse>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _webhooksAccountsUserGroupPut({
    required WebhookUpdateUserGroupRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/v2/webhooks/accounts/user-group');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
