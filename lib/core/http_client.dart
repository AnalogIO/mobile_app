import 'package:cafe_analog_app/generated/api/coffeecard_api_v1.swagger.dart'
    hide $JsonSerializableConverter;
import 'package:cafe_analog_app/generated/api/coffeecard_api_v2.swagger.dart';
import 'package:chopper/chopper.dart';

final _httpClient = ChopperClient(
  baseUrl: Uri.parse('https://core.dev.analogio.dk'),
  interceptors: [],
  converter: $JsonSerializableConverter(),
  services: [CoffeecardApiV1.create(), CoffeecardApiV2.create()],
  // authenticator: sl.get<ReactivationAuthenticator>(),
);

final CoffeecardApiV1 apiV1 = CoffeecardApiV1.create(client: _httpClient);
final CoffeecardApiV2 apiV2 = CoffeecardApiV2.create(client: _httpClient);
