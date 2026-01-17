// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'coffeecard_api_v1.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
export 'coffeecard_api_v1.models.swagger.dart';

part 'coffeecard_api_v1.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class CoffeecardApiV1 extends ChopperService {
  static CoffeecardApiV1 create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$CoffeecardApiV1(client);
    }

    final newClient = ChopperClient(
      services: [_$CoffeecardApiV1()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl,
    );
    return _$CoffeecardApiV1(newClient);
  }

  ///Register a new account. A account is required to verify its email before logging in
  Future<chopper.Response<MessageResponseDto>> accountRegisterPost({
    required RegisterDto? body,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDto,
      () => MessageResponseDto.fromJsonFactory,
    );

    return _accountRegisterPost(body: body);
  }

  ///Register a new account. A account is required to verify its email before logging in
  @POST(path: '/api/v1/Account/register', optionalBody: true)
  Future<chopper.Response<MessageResponseDto>> _accountRegisterPost({
    @Body() required RegisterDto? body,
  });

  ///Returns a token that is used to identify the account
  Future<chopper.Response<TokenDto>> accountLoginPost({
    required LoginDto? body,
  }) {
    generatedMapping.putIfAbsent(TokenDto, () => TokenDto.fromJsonFactory);

    return _accountLoginPost(body: body);
  }

  ///Returns a token that is used to identify the account
  @POST(path: '/api/v1/Account/login', optionalBody: true)
  Future<chopper.Response<TokenDto>> _accountLoginPost({
    @Body() required LoginDto? body,
  });

  ///Returns basic data about the account
  Future<chopper.Response> accountGet() {
    return _accountGet();
  }

  ///Returns basic data about the account
  @GET(path: '/api/v1/Account')
  Future<chopper.Response> _accountGet();

  ///Updates the account and returns the updated values.
  ///Only properties which are present in the UpdateUserDto will be updated
  Future<chopper.Response> accountPut({required UpdateUserDto? body}) {
    return _accountPut(body: body);
  }

  ///Updates the account and returns the updated values.
  ///Only properties which are present in the UpdateUserDto will be updated
  @PUT(path: '/api/v1/Account', optionalBody: true)
  Future<chopper.Response> _accountPut({@Body() required UpdateUserDto? body});

  ///
  Future<chopper.Response<MessageResponseDto>> accountForgotpasswordPost({
    required EmailDto? body,
  }) {
    generatedMapping.putIfAbsent(
      MessageResponseDto,
      () => MessageResponseDto.fromJsonFactory,
    );

    return _accountForgotpasswordPost(body: body);
  }

  ///
  @POST(path: '/api/v1/Account/forgotpassword', optionalBody: true)
  Future<chopper.Response<MessageResponseDto>> _accountForgotpasswordPost({
    @Body() required EmailDto? body,
  });

  ///Get app configuration
  @deprecated
  Future<chopper.Response> appConfigGet() {
    return _appConfigGet();
  }

  ///Get app configuration
  @deprecated
  @GET(path: '/api/v1/AppConfig')
  Future<chopper.Response> _appConfigGet();

  ///Retrieve the coffee cards of the account
  Future<chopper.Response<CoffeeCardDto>> coffeeCardsGet() {
    generatedMapping.putIfAbsent(
      CoffeeCardDto,
      () => CoffeeCardDto.fromJsonFactory,
    );

    return _coffeeCardsGet();
  }

  ///Retrieve the coffee cards of the account
  @GET(path: '/api/v1/CoffeeCards')
  Future<chopper.Response<CoffeeCardDto>> _coffeeCardsGet();

  ///Gets the leaderboard by the specified preset
  ///@param preset Leaderboard preset. 0 - Monthly, 1 - Semester and 2 - Total
  ///@param top Number of results to return
  Future<chopper.Response> leaderboardGet({int? preset, int? top}) {
    return _leaderboardGet(preset: preset, top: top);
  }

  ///Gets the leaderboard by the specified preset
  ///@param preset Leaderboard preset. 0 - Monthly, 1 - Semester and 2 - Total
  ///@param top Number of results to return
  @GET(path: '/api/v1/Leaderboard')
  Future<chopper.Response> _leaderboardGet({
    @Query('preset') int? preset,
    @Query('top') int? top,
  });

  ///Initiates a purchase from the given productId and returns an orderId
  @deprecated
  Future<chopper.Response> mobilePayInitiatePost({
    required InitiatePurchaseDto? body,
  }) {
    return _mobilePayInitiatePost(body: body);
  }

  ///Initiates a purchase from the given productId and returns an orderId
  @deprecated
  @POST(path: '/api/v1/MobilePay/initiate', optionalBody: true)
  Future<chopper.Response> _mobilePayInitiatePost({
    @Body() required InitiatePurchaseDto? body,
  });

  ///Validates the purchase against MobilePay and delivers the tickets if succeeded
  @deprecated
  Future<chopper.Response> mobilePayCompletePost({
    required CompletePurchaseDto? body,
  }) {
    return _mobilePayCompletePost(body: body);
  }

  ///Validates the purchase against MobilePay and delivers the tickets if succeeded
  @deprecated
  @POST(path: '/api/v1/MobilePay/complete', optionalBody: true)
  Future<chopper.Response> _mobilePayCompletePost({
    @Body() required CompletePurchaseDto? body,
  });

  ///Ping
  @deprecated
  Future<chopper.Response<String>> pingGet() {
    return _pingGet();
  }

  ///Ping
  @deprecated
  @GET(path: '/api/v1/Ping')
  Future<chopper.Response<String>> _pingGet();

  ///Returns a list of available products based on a account's user group
  Future<chopper.Response<List<ProductDto>>> productsGet() {
    generatedMapping.putIfAbsent(ProductDto, () => ProductDto.fromJsonFactory);

    return _productsGet();
  }

  ///Returns a list of available products based on a account's user group
  @GET(path: '/api/v1/Products')
  Future<chopper.Response<List<ProductDto>>> _productsGet();

  ///Returns a list of available products based on a account's user group
  Future<chopper.Response<List<ProductDto>>> productsAppGet() {
    generatedMapping.putIfAbsent(ProductDto, () => ProductDto.fromJsonFactory);

    return _productsAppGet();
  }

  ///Returns a list of available products based on a account's user group
  @GET(path: '/api/v1/Products/app')
  Future<chopper.Response<List<ProductDto>>> _productsAppGet();

  ///Returns a list of available programmes
  Future<chopper.Response<List<ProgrammeDto>>> programmesGet() {
    generatedMapping.putIfAbsent(
      ProgrammeDto,
      () => ProgrammeDto.fromJsonFactory,
    );

    return _programmesGet();
  }

  ///Returns a list of available programmes
  @GET(path: '/api/v1/Programmes')
  Future<chopper.Response<List<ProgrammeDto>>> _programmesGet();

  ///Returns a list of purchases for the given user via the supplied token in the header
  @deprecated
  Future<chopper.Response> purchasesGet() {
    return _purchasesGet();
  }

  ///Returns a list of purchases for the given user via the supplied token in the header
  @deprecated
  @GET(path: '/api/v1/Purchases')
  Future<chopper.Response> _purchasesGet();

  ///Redeems the voucher supplied as parameter in the path
  ///@param voucherCode
  Future<chopper.Response<PurchaseDto>> purchasesRedeemvoucherPost({
    String? voucherCode,
  }) {
    generatedMapping.putIfAbsent(
      PurchaseDto,
      () => PurchaseDto.fromJsonFactory,
    );

    return _purchasesRedeemvoucherPost(voucherCode: voucherCode);
  }

  ///Redeems the voucher supplied as parameter in the path
  ///@param voucherCode
  @POST(path: '/api/v1/Purchases/redeemvoucher', optionalBody: true)
  Future<chopper.Response<PurchaseDto>> _purchasesRedeemvoucherPost({
    @Query('voucherCode') String? voucherCode,
  });

  ///Issue purchase used by the ipad in the cafe
  @deprecated
  Future<chopper.Response> purchasesIssueproductPost({
    required IssueProductDto? body,
  }) {
    return _purchasesIssueproductPost(body: body);
  }

  ///Issue purchase used by the ipad in the cafe
  @deprecated
  @POST(path: '/api/v1/Purchases/issueproduct', optionalBody: true)
  Future<chopper.Response> _purchasesIssueproductPost({
    @Body() required IssueProductDto? body,
  });

  ///Returns a list of tickets
  ///@param used Include already used tickets
  Future<chopper.Response<List<TicketDto>>> ticketsGet({bool? used}) {
    generatedMapping.putIfAbsent(TicketDto, () => TicketDto.fromJsonFactory);

    return _ticketsGet(used: used);
  }

  ///Returns a list of tickets
  ///@param used Include already used tickets
  @GET(path: '/api/v1/Tickets')
  Future<chopper.Response<List<TicketDto>>> _ticketsGet({
    @Query('used') bool? used,
  });

  ///Uses the tickets supplied via product ids in the body
  Future<chopper.Response<List<TicketDto>>> ticketsUseMultiplePost({
    required UseMultipleTicketDto? body,
  }) {
    generatedMapping.putIfAbsent(TicketDto, () => TicketDto.fromJsonFactory);

    return _ticketsUseMultiplePost(body: body);
  }

  ///Uses the tickets supplied via product ids in the body
  @POST(path: '/api/v1/Tickets/useMultiple', optionalBody: true)
  Future<chopper.Response<List<TicketDto>>> _ticketsUseMultiplePost({
    @Body() required UseMultipleTicketDto? body,
  });

  ///Use ticket request
  Future<chopper.Response<UsedTicketResponse>> ticketsUsePost({
    required UseTicketDto? body,
  }) {
    generatedMapping.putIfAbsent(
      UsedTicketResponse,
      () => UsedTicketResponse.fromJsonFactory,
    );

    return _ticketsUsePost(body: body);
  }

  ///Use ticket request
  @POST(path: '/api/v1/Tickets/use', optionalBody: true)
  Future<chopper.Response<UsedTicketResponse>> _ticketsUsePost({
    @Body() required UseTicketDto? body,
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
