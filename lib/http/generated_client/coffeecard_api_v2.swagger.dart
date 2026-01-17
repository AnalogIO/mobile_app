// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'coffeecard_api_v2.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'coffeecard_api_v2.enums.swagger.dart' as enums;
export 'coffeecard_api_v2.enums.swagger.dart';
export 'coffeecard_api_v2.models.swagger.dart';

part 'coffeecard_api_v2.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class CoffeecardApiV2 extends ChopperService {
  static CoffeecardApiV2 create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$CoffeecardApiV2(client);
    }

    final newClient = ChopperClient(
      services: [_$CoffeecardApiV2()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl,
    );
    return _$CoffeecardApiV2(newClient);
  }

  ///Register data request. An account is required to verify its email before logging in
  Future<chopper.Response<MessageResponseDto>> accountPost({
    required RegisterAccountRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDto,
      () => MessageResponseDto.fromJsonFactory,
    );

    return _accountPost(body: body);
  }

  ///Register data request. An account is required to verify its email before logging in
  @POST(path: '/api/v2/account', optionalBody: true)
  Future<chopper.Response<MessageResponseDto>> _accountPost({
    @Body() required RegisterAccountRequest? body,
  });

  ///Request the deletion of the user coupled to the provided token
  Future<chopper.Response> accountDelete() {
    return _accountDelete();
  }

  ///Request the deletion of the user coupled to the provided token
  @DELETE(path: '/api/v2/account')
  Future<chopper.Response> _accountDelete();

  ///Returns basic data about the account
  Future<chopper.Response<UserResponse>> accountGet() {
    generatedMapping.putIfAbsent(
      UserResponse,
      () => UserResponse.fromJsonFactory,
    );

    return _accountGet();
  }

  ///Returns basic data about the account
  @GET(path: '/api/v2/account')
  Future<chopper.Response<UserResponse>> _accountGet();

  ///Updates the account and returns the updated values.
  ///Only properties which are present in the UpdateUserRequest will be updated
  Future<chopper.Response<UserResponse>> accountPut({
    required UpdateUserRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      UserResponse,
      () => UserResponse.fromJsonFactory,
    );

    return _accountPut(body: body);
  }

  ///Updates the account and returns the updated values.
  ///Only properties which are present in the UpdateUserRequest will be updated
  @PUT(path: '/api/v2/account', optionalBody: true)
  Future<chopper.Response<UserResponse>> _accountPut({
    @Body() required UpdateUserRequest? body,
  });

  ///Check if a given email is in use
  Future<chopper.Response<EmailExistsResponse>> accountEmailExistsPost({
    required EmailExistsRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      EmailExistsResponse,
      () => EmailExistsResponse.fromJsonFactory,
    );

    return _accountEmailExistsPost(body: body);
  }

  ///Check if a given email is in use
  @POST(path: '/api/v2/account/email-exists', optionalBody: true)
  Future<chopper.Response<EmailExistsResponse>> _accountEmailExistsPost({
    @Body() required EmailExistsRequest? body,
  });

  ///Updates the user group of a user
  ///@param id id of the user whose userGroup will be updated
  Future<chopper.Response> accountIdUserGroupPatch({
    required int? id,
    required UpdateUserGroupRequest? body,
  }) {
    return _accountIdUserGroupPatch(id: id, body: body);
  }

  ///Updates the user group of a user
  ///@param id id of the user whose userGroup will be updated
  @PATCH(path: '/api/v2/account/{id}/user-group', optionalBody: true)
  Future<chopper.Response> _accountIdUserGroupPatch({
    @Path('id') required int? id,
    @Body() required UpdateUserGroupRequest? body,
  });

  ///Resend account verification email if account is not already verified
  Future<chopper.Response> accountResendVerificationEmailPost({
    required ResendAccountVerificationEmailRequest? body,
  }) {
    return _accountResendVerificationEmailPost(body: body);
  }

  ///Resend account verification email if account is not already verified
  @POST(path: '/api/v2/account/resend-verification-email', optionalBody: true)
  Future<chopper.Response> _accountResendVerificationEmailPost({
    @Body() required ResendAccountVerificationEmailRequest? body,
  });

  ///Searches a user in the database
  ///@param pageNum The page number
  ///@param filter A filter to search by Id, Name or Email. When an empty string is given, all users will be returned
  ///@param pageLength The length of a page
  Future<chopper.Response<UserSearchResponse>> accountSearchGet({
    int? pageNum,
    String? filter,
    int? pageLength,
  }) {
    generatedMapping.putIfAbsent(
      UserSearchResponse,
      () => UserSearchResponse.fromJsonFactory,
    );

    return _accountSearchGet(
      pageNum: pageNum,
      filter: filter,
      pageLength: pageLength,
    );
  }

  ///Searches a user in the database
  ///@param pageNum The page number
  ///@param filter A filter to search by Id, Name or Email. When an empty string is given, all users will be returned
  ///@param pageLength The length of a page
  @GET(path: '/api/v2/account/search')
  Future<chopper.Response<UserSearchResponse>> _accountSearchGet({
    @Query('pageNum') int? pageNum,
    @Query('filter') String? filter,
    @Query('pageLength') int? pageLength,
  });

  ///Sends a magic link to the user's email to login
  Future<chopper.Response> accountLoginPost({required UserLoginRequest? body}) {
    return _accountLoginPost(body: body);
  }

  ///Sends a magic link to the user's email to login
  @POST(path: '/api/v2/account/login', optionalBody: true)
  Future<chopper.Response> _accountLoginPost({
    @Body() required UserLoginRequest? body,
  });

  ///Authenticates the user with the token hash from a magic link
  Future<chopper.Response<UserLoginResponse>> accountAuthPost({
    required TokenLoginRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      UserLoginResponse,
      () => UserLoginResponse.fromJsonFactory,
    );

    return _accountAuthPost(body: body);
  }

  ///Authenticates the user with the token hash from a magic link
  @POST(path: '/api/v2/account/auth', optionalBody: true)
  Future<chopper.Response<UserLoginResponse>> _accountAuthPost({
    @Body() required TokenLoginRequest? body,
  });

  ///Sum unused clip cards within a given period per productId
  Future<chopper.Response<List<UnusedClipsResponse>>>
  statisticsUnusedClipsPost({required UnusedClipsRequest? body}) {
    generatedMapping.putIfAbsent(
      UnusedClipsResponse,
      () => UnusedClipsResponse.fromJsonFactory,
    );

    return _statisticsUnusedClipsPost(body: body);
  }

  ///Sum unused clip cards within a given period per productId
  @POST(path: '/api/v2/statistics/unused-clips', optionalBody: true)
  Future<chopper.Response<List<UnusedClipsResponse>>>
  _statisticsUnusedClipsPost({@Body() required UnusedClipsRequest? body});

  ///Get app configuration
  Future<chopper.Response<AppConfig>> appconfigGet() {
    generatedMapping.putIfAbsent(AppConfig, () => AppConfig.fromJsonFactory);

    return _appconfigGet();
  }

  ///Get app configuration
  @GET(path: '/api/v2/appconfig')
  Future<chopper.Response<AppConfig>> _appconfigGet();

  ///Ping
  Future<chopper.Response<String>> healthPingGet() {
    return _healthPingGet();
  }

  ///Ping
  @GET(path: '/api/v2/health/ping')
  Future<chopper.Response<String>> _healthPingGet();

  ///Check service health
  Future<chopper.Response<ServiceHealthResponse>> healthCheckGet() {
    generatedMapping.putIfAbsent(
      ServiceHealthResponse,
      () => ServiceHealthResponse.fromJsonFactory,
    );

    return _healthCheckGet();
  }

  ///Check service health
  @GET(path: '/api/v2/health/check')
  Future<chopper.Response<ServiceHealthResponse>> _healthCheckGet();

  ///Gets the top leaderboard by the specified preset
  ///@param preset Leaderboard preset for date filtering. See LeaderboardPreset for possible values
  ///@param top Number of top results to return
  Future<chopper.Response<List<LeaderboardEntry>>> leaderboardTopGet({
    Object? preset,
    int? top,
  }) {
    generatedMapping.putIfAbsent(
      LeaderboardEntry,
      () => LeaderboardEntry.fromJsonFactory,
    );

    return _leaderboardTopGet(preset: preset, top: top);
  }

  ///Gets the top leaderboard by the specified preset
  ///@param preset Leaderboard preset for date filtering. See LeaderboardPreset for possible values
  ///@param top Number of top results to return
  @GET(path: '/api/v2/leaderboard/top')
  Future<chopper.Response<List<LeaderboardEntry>>> _leaderboardTopGet({
    @Query('preset') Object? preset,
    @Query('top') int? top,
  });

  ///Get leaderboard stats for authenticated user. A user will have rank 0 if they do not have any valid swipes
  ///@param preset Leaderboard preset for date filtering. See LeaderboardPreset for possible values
  Future<chopper.Response<LeaderboardEntry>> leaderboardGet({Object? preset}) {
    generatedMapping.putIfAbsent(
      LeaderboardEntry,
      () => LeaderboardEntry.fromJsonFactory,
    );

    return _leaderboardGet(preset: preset);
  }

  ///Get leaderboard stats for authenticated user. A user will have rank 0 if they do not have any valid swipes
  ///@param preset Leaderboard preset for date filtering. See LeaderboardPreset for possible values
  @GET(path: '/api/v2/leaderboard')
  Future<chopper.Response<LeaderboardEntry>> _leaderboardGet({
    @Query('preset') Object? preset,
  });

  ///Returns a list of all menu items
  Future<chopper.Response<List<MenuItemResponse>>> menuitemsGet() {
    generatedMapping.putIfAbsent(
      MenuItemResponse,
      () => MenuItemResponse.fromJsonFactory,
    );

    return _menuitemsGet();
  }

  ///Returns a list of all menu items
  @GET(path: '/api/v2/menuitems')
  Future<chopper.Response<List<MenuItemResponse>>> _menuitemsGet();

  ///Adds a menu item
  Future<chopper.Response<MenuItemResponse>> menuitemsPost({
    required AddMenuItemRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      MenuItemResponse,
      () => MenuItemResponse.fromJsonFactory,
    );

    return _menuitemsPost(body: body);
  }

  ///Adds a menu item
  @POST(path: '/api/v2/menuitems', optionalBody: true)
  Future<chopper.Response<MenuItemResponse>> _menuitemsPost({
    @Body() required AddMenuItemRequest? body,
  });

  ///Updates a menu item
  ///@param id Menu item id to update
  Future<chopper.Response<MenuItemResponse>> menuitemsIdPut({
    required int? id,
    required UpdateMenuItemRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      MenuItemResponse,
      () => MenuItemResponse.fromJsonFactory,
    );

    return _menuitemsIdPut(id: id, body: body);
  }

  ///Updates a menu item
  ///@param id Menu item id to update
  @PUT(path: '/api/v2/menuitems/{id}', optionalBody: true)
  Future<chopper.Response<MenuItemResponse>> _menuitemsIdPut({
    @Path('id') required int? id,
    @Body() required UpdateMenuItemRequest? body,
  });

  ///Adds a new product
  Future<chopper.Response<ProductResponse>> productsPost({
    required AddProductRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductResponse,
      () => ProductResponse.fromJsonFactory,
    );

    return _productsPost(body: body);
  }

  ///Adds a new product
  @POST(path: '/api/v2/products', optionalBody: true)
  Future<chopper.Response<ProductResponse>> _productsPost({
    @Body() required AddProductRequest? body,
  });

  ///Returns a list of available products based on a account's user group.
  Future<chopper.Response<List<ProductResponse>>> productsGet() {
    generatedMapping.putIfAbsent(
      ProductResponse,
      () => ProductResponse.fromJsonFactory,
    );

    return _productsGet();
  }

  ///Returns a list of available products based on a account's user group.
  @GET(path: '/api/v2/products')
  Future<chopper.Response<List<ProductResponse>>> _productsGet();

  ///Updates a product with the specified changes.
  ///@param id Product Id
  Future<chopper.Response<ProductResponse>> productsIdPut({
    required int? id,
    required UpdateProductRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductResponse,
      () => ProductResponse.fromJsonFactory,
    );

    return _productsIdPut(id: id, body: body);
  }

  ///Updates a product with the specified changes.
  ///@param id Product Id
  @PUT(path: '/api/v2/products/{id}', optionalBody: true)
  Future<chopper.Response<ProductResponse>> _productsIdPut({
    @Path('id') required int? id,
    @Body() required UpdateProductRequest? body,
  });

  ///Returns a product with the specified id
  ///@param id The id of the product to be returned
  Future<chopper.Response<ProductResponse>> productsIdGet({required int? id}) {
    generatedMapping.putIfAbsent(
      ProductResponse,
      () => ProductResponse.fromJsonFactory,
    );

    return _productsIdGet(id: id);
  }

  ///Returns a product with the specified id
  ///@param id The id of the product to be returned
  @GET(path: '/api/v2/products/{id}')
  Future<chopper.Response<ProductResponse>> _productsIdGet({
    @Path('id') required int? id,
  });

  ///Returns a list of all products
  Future<chopper.Response<List<ProductResponse>>> productsAllGet() {
    generatedMapping.putIfAbsent(
      ProductResponse,
      () => ProductResponse.fromJsonFactory,
    );

    return _productsAllGet();
  }

  ///Returns a list of all products
  @GET(path: '/api/v2/products/all')
  Future<chopper.Response<List<ProductResponse>>> _productsAllGet();

  ///Get all purchases
  Future<chopper.Response<List<SimplePurchaseResponse>>> purchasesGet() {
    generatedMapping.putIfAbsent(
      SimplePurchaseResponse,
      () => SimplePurchaseResponse.fromJsonFactory,
    );

    return _purchasesGet();
  }

  ///Get all purchases
  @GET(path: '/api/v2/purchases')
  Future<chopper.Response<List<SimplePurchaseResponse>>> _purchasesGet();

  ///Initiate a new payment.
  Future<chopper.Response<InitiatePurchaseResponse>> purchasesPost({
    required InitiatePurchaseRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      InitiatePurchaseResponse,
      () => InitiatePurchaseResponse.fromJsonFactory,
    );

    return _purchasesPost(body: body);
  }

  ///Initiate a new payment.
  @POST(path: '/api/v2/purchases', optionalBody: true)
  Future<chopper.Response<InitiatePurchaseResponse>> _purchasesPost({
    @Body() required InitiatePurchaseRequest? body,
  });

  ///Get all purchases for a user
  ///@param userId User Id
  Future<chopper.Response<List<SimplePurchaseResponse>>>
  purchasesUserUserIdGet({required int? userId}) {
    generatedMapping.putIfAbsent(
      SimplePurchaseResponse,
      () => SimplePurchaseResponse.fromJsonFactory,
    );

    return _purchasesUserUserIdGet(userId: userId);
  }

  ///Get all purchases for a user
  ///@param userId User Id
  @GET(path: '/api/v2/purchases/user/{userId}')
  Future<chopper.Response<List<SimplePurchaseResponse>>>
  _purchasesUserUserIdGet({@Path('userId') required int? userId});

  ///Get purchase
  ///@param id Purchase Id
  Future<chopper.Response<SinglePurchaseResponse>> purchasesIdGet({
    required int? id,
  }) {
    generatedMapping.putIfAbsent(
      SinglePurchaseResponse,
      () => SinglePurchaseResponse.fromJsonFactory,
    );

    return _purchasesIdGet(id: id);
  }

  ///Get purchase
  ///@param id Purchase Id
  @GET(path: '/api/v2/purchases/{id}')
  Future<chopper.Response<SinglePurchaseResponse>> _purchasesIdGet({
    @Path('id') required int? id,
  });

  ///Refunds a payment
  ///@param id database id of purchase
  Future<chopper.Response<SimplePurchaseResponse>> purchasesIdRefundPut({
    required int? id,
  }) {
    generatedMapping.putIfAbsent(
      SimplePurchaseResponse,
      () => SimplePurchaseResponse.fromJsonFactory,
    );

    return _purchasesIdRefundPut(id: id);
  }

  ///Refunds a payment
  ///@param id database id of purchase
  @PUT(path: '/api/v2/purchases/{id}/refund', optionalBody: true)
  Future<chopper.Response<SimplePurchaseResponse>> _purchasesIdRefundPut({
    @Path('id') required int? id,
  });

  ///Returns a list of tickets
  ///@param includeUsed Include already used tickets
  Future<chopper.Response<List<TicketResponse>>> ticketsGet({
    bool? includeUsed,
  }) {
    generatedMapping.putIfAbsent(
      TicketResponse,
      () => TicketResponse.fromJsonFactory,
    );

    return _ticketsGet(includeUsed: includeUsed);
  }

  ///Returns a list of tickets
  ///@param includeUsed Include already used tickets
  @GET(path: '/api/v2/tickets')
  Future<chopper.Response<List<TicketResponse>>> _ticketsGet({
    @Query('includeUsed') bool? includeUsed,
  });

  ///Uses a ticket (for the given product) on the given menu item
  Future<chopper.Response<UsedTicketResponse>> ticketsUsePost({
    required UseTicketRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      UsedTicketResponse,
      () => UsedTicketResponse.fromJsonFactory,
    );

    return _ticketsUsePost(body: body);
  }

  ///Uses a ticket (for the given product) on the given menu item
  @POST(path: '/api/v2/tickets/use', optionalBody: true)
  Future<chopper.Response<UsedTicketResponse>> _ticketsUsePost({
    @Body() required UseTicketRequest? body,
  });

  ///Issue voucher codes, that can later be redeemed
  Future<chopper.Response<List<IssueVoucherResponse>>>
  vouchersIssueVouchersPost({required IssueVoucherRequest? body}) {
    generatedMapping.putIfAbsent(
      IssueVoucherResponse,
      () => IssueVoucherResponse.fromJsonFactory,
    );

    return _vouchersIssueVouchersPost(body: body);
  }

  ///Issue voucher codes, that can later be redeemed
  @POST(path: '/api/v2/vouchers/issue-vouchers', optionalBody: true)
  Future<chopper.Response<List<IssueVoucherResponse>>>
  _vouchersIssueVouchersPost({@Body() required IssueVoucherRequest? body});

  ///Redeems the voucher supplied as parameter in the path
  ///@param voucher-code
  Future<chopper.Response<SimplePurchaseResponse>>
  vouchersVoucherCodeRedeemPost({required String? voucherCode}) {
    generatedMapping.putIfAbsent(
      SimplePurchaseResponse,
      () => SimplePurchaseResponse.fromJsonFactory,
    );

    return _vouchersVoucherCodeRedeemPost(voucherCode: voucherCode);
  }

  ///Redeems the voucher supplied as parameter in the path
  ///@param voucher-code
  @POST(path: '/api/v2/vouchers/{voucher-code}/redeem', optionalBody: true)
  Future<chopper.Response<SimplePurchaseResponse>>
  _vouchersVoucherCodeRedeemPost({
    @Path('voucher-code') required String? voucherCode,
  });

  ///Update user groups in bulk
  Future<chopper.Response> webhooksAccountsUserGroupPut({
    required WebhookUpdateUserGroupRequest? body,
  }) {
    return _webhooksAccountsUserGroupPut(body: body);
  }

  ///Update user groups in bulk
  @PUT(path: '/api/v2/webhooks/accounts/user-group', optionalBody: true)
  Future<chopper.Response> _webhooksAccountsUserGroupPut({
    @Body() required WebhookUpdateUserGroupRequest? body,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
