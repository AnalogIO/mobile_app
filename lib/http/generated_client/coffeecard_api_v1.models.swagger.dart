// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

part 'coffeecard_api_v1.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageResponseDto {
  const MessageResponseDto({this.message});

  factory MessageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDtoFromJson(json);

  static const toJsonFactory = _$MessageResponseDtoToJson;
  Map<String, dynamic> toJson() => _$MessageResponseDtoToJson(this);

  @JsonKey(name: 'message', includeIfNull: true)
  final String? message;
  static const fromJsonFactory = _$MessageResponseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MessageResponseDto &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^ runtimeType.hashCode;
}

extension $MessageResponseDtoExtension on MessageResponseDto {
  MessageResponseDto copyWith({String? message}) {
    return MessageResponseDto(message: message ?? this.message);
  }

  MessageResponseDto copyWithWrapped({Wrapped<String?>? message}) {
    return MessageResponseDto(
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RegisterDto {
  const RegisterDto({
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  static const toJsonFactory = _$RegisterDtoToJson;
  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  @JsonKey(name: 'password', includeIfNull: true)
  final String password;
  static const fromJsonFactory = _$RegisterDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RegisterDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $RegisterDtoExtension on RegisterDto {
  RegisterDto copyWith({String? name, String? email, String? password}) {
    return RegisterDto(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  RegisterDto copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? email,
    Wrapped<String>? password,
  }) {
    return RegisterDto(
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenDto {
  const TokenDto({this.token});

  factory TokenDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDtoFromJson(json);

  static const toJsonFactory = _$TokenDtoToJson;
  Map<String, dynamic> toJson() => _$TokenDtoToJson(this);

  @JsonKey(name: 'token', includeIfNull: true)
  final String? token;
  static const fromJsonFactory = _$TokenDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenDto &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^ runtimeType.hashCode;
}

extension $TokenDtoExtension on TokenDto {
  TokenDto copyWith({String? token}) {
    return TokenDto(token: token ?? this.token);
  }

  TokenDto copyWithWrapped({Wrapped<String?>? token}) {
    return TokenDto(token: (token != null ? token.value : this.token));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiError {
  const ApiError({this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  static const toJsonFactory = _$ApiErrorToJson;
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @JsonKey(name: 'message', includeIfNull: true)
  final String? message;
  static const fromJsonFactory = _$ApiErrorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^ runtimeType.hashCode;
}

extension $ApiErrorExtension on ApiError {
  ApiError copyWith({String? message}) {
    return ApiError(message: message ?? this.message);
  }

  ApiError copyWithWrapped({Wrapped<String?>? message}) {
    return ApiError(message: (message != null ? message.value : this.message));
  }
}

@JsonSerializable(explicitToJson: true)
class LoginDto {
  const LoginDto({
    required this.email,
    required this.password,
    required this.version,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  static const toJsonFactory = _$LoginDtoToJson;
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  @JsonKey(name: 'password', includeIfNull: true)
  final String password;
  @JsonKey(name: 'version', includeIfNull: true)
  final String version;
  static const fromJsonFactory = _$LoginDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginDto &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(other.version, version)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(version) ^
      runtimeType.hashCode;
}

extension $LoginDtoExtension on LoginDto {
  LoginDto copyWith({String? email, String? password, String? version}) {
    return LoginDto(
      email: email ?? this.email,
      password: password ?? this.password,
      version: version ?? this.version,
    );
  }

  LoginDto copyWithWrapped({
    Wrapped<String>? email,
    Wrapped<String>? password,
    Wrapped<String>? version,
  }) {
    return LoginDto(
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
      version: (version != null ? version.value : this.version),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateUserDto {
  const UpdateUserDto({
    this.name,
    this.email,
    this.privacyActivated,
    this.programmeId,
    this.password,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  static const toJsonFactory = _$UpdateUserDtoToJson;
  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);

  @JsonKey(name: 'name', includeIfNull: true)
  final String? name;
  @JsonKey(name: 'email', includeIfNull: true)
  final String? email;
  @JsonKey(name: 'privacyActivated', includeIfNull: true)
  final bool? privacyActivated;
  @JsonKey(name: 'programmeId', includeIfNull: true)
  final int? programmeId;
  @JsonKey(name: 'password', includeIfNull: true)
  final String? password;
  static const fromJsonFactory = _$UpdateUserDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateUserDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.privacyActivated, privacyActivated) ||
                const DeepCollectionEquality().equals(
                  other.privacyActivated,
                  privacyActivated,
                )) &&
            (identical(other.programmeId, programmeId) ||
                const DeepCollectionEquality().equals(
                  other.programmeId,
                  programmeId,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(privacyActivated) ^
      const DeepCollectionEquality().hash(programmeId) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $UpdateUserDtoExtension on UpdateUserDto {
  UpdateUserDto copyWith({
    String? name,
    String? email,
    bool? privacyActivated,
    int? programmeId,
    String? password,
  }) {
    return UpdateUserDto(
      name: name ?? this.name,
      email: email ?? this.email,
      privacyActivated: privacyActivated ?? this.privacyActivated,
      programmeId: programmeId ?? this.programmeId,
      password: password ?? this.password,
    );
  }

  UpdateUserDto copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? email,
    Wrapped<bool?>? privacyActivated,
    Wrapped<int?>? programmeId,
    Wrapped<String?>? password,
  }) {
    return UpdateUserDto(
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      privacyActivated: (privacyActivated != null
          ? privacyActivated.value
          : this.privacyActivated),
      programmeId: (programmeId != null ? programmeId.value : this.programmeId),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EmailDto {
  const EmailDto({required this.email});

  factory EmailDto.fromJson(Map<String, dynamic> json) =>
      _$EmailDtoFromJson(json);

  static const toJsonFactory = _$EmailDtoToJson;
  Map<String, dynamic> toJson() => _$EmailDtoToJson(this);

  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  static const fromJsonFactory = _$EmailDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EmailDto &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $EmailDtoExtension on EmailDto {
  EmailDto copyWith({String? email}) {
    return EmailDto(email: email ?? this.email);
  }

  EmailDto copyWithWrapped({Wrapped<String>? email}) {
    return EmailDto(email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class CoffeeCardDto {
  const CoffeeCardDto({
    required this.productId,
    required this.name,
    required this.ticketsLeft,
    required this.price,
    required this.quantity,
  });

  factory CoffeeCardDto.fromJson(Map<String, dynamic> json) =>
      _$CoffeeCardDtoFromJson(json);

  static const toJsonFactory = _$CoffeeCardDtoToJson;
  Map<String, dynamic> toJson() => _$CoffeeCardDtoToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'ticketsLeft', includeIfNull: true)
  final int ticketsLeft;
  @JsonKey(name: 'price', includeIfNull: true)
  final int price;
  @JsonKey(name: 'quantity', includeIfNull: true)
  final int quantity;
  static const fromJsonFactory = _$CoffeeCardDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoffeeCardDto &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.ticketsLeft, ticketsLeft) ||
                const DeepCollectionEquality().equals(
                  other.ticketsLeft,
                  ticketsLeft,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(ticketsLeft) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(quantity) ^
      runtimeType.hashCode;
}

extension $CoffeeCardDtoExtension on CoffeeCardDto {
  CoffeeCardDto copyWith({
    int? productId,
    String? name,
    int? ticketsLeft,
    int? price,
    int? quantity,
  }) {
    return CoffeeCardDto(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      ticketsLeft: ticketsLeft ?? this.ticketsLeft,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  CoffeeCardDto copyWithWrapped({
    Wrapped<int>? productId,
    Wrapped<String>? name,
    Wrapped<int>? ticketsLeft,
    Wrapped<int>? price,
    Wrapped<int>? quantity,
  }) {
    return CoffeeCardDto(
      productId: (productId != null ? productId.value : this.productId),
      name: (name != null ? name.value : this.name),
      ticketsLeft: (ticketsLeft != null ? ticketsLeft.value : this.ticketsLeft),
      price: (price != null ? price.value : this.price),
      quantity: (quantity != null ? quantity.value : this.quantity),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class InitiatePurchaseDto {
  const InitiatePurchaseDto({required this.productId});

  factory InitiatePurchaseDto.fromJson(Map<String, dynamic> json) =>
      _$InitiatePurchaseDtoFromJson(json);

  static const toJsonFactory = _$InitiatePurchaseDtoToJson;
  Map<String, dynamic> toJson() => _$InitiatePurchaseDtoToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  static const fromJsonFactory = _$InitiatePurchaseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InitiatePurchaseDto &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^ runtimeType.hashCode;
}

extension $InitiatePurchaseDtoExtension on InitiatePurchaseDto {
  InitiatePurchaseDto copyWith({int? productId}) {
    return InitiatePurchaseDto(productId: productId ?? this.productId);
  }

  InitiatePurchaseDto copyWithWrapped({Wrapped<int>? productId}) {
    return InitiatePurchaseDto(
      productId: (productId != null ? productId.value : this.productId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CompletePurchaseDto {
  const CompletePurchaseDto({
    required this.orderId,
    required this.transactionId,
  });

  factory CompletePurchaseDto.fromJson(Map<String, dynamic> json) =>
      _$CompletePurchaseDtoFromJson(json);

  static const toJsonFactory = _$CompletePurchaseDtoToJson;
  Map<String, dynamic> toJson() => _$CompletePurchaseDtoToJson(this);

  @JsonKey(name: 'orderId', includeIfNull: true)
  final String orderId;
  @JsonKey(name: 'transactionId', includeIfNull: true)
  final String transactionId;
  static const fromJsonFactory = _$CompletePurchaseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CompletePurchaseDto &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality().equals(
                  other.transactionId,
                  transactionId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(transactionId) ^
      runtimeType.hashCode;
}

extension $CompletePurchaseDtoExtension on CompletePurchaseDto {
  CompletePurchaseDto copyWith({String? orderId, String? transactionId}) {
    return CompletePurchaseDto(
      orderId: orderId ?? this.orderId,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  CompletePurchaseDto copyWithWrapped({
    Wrapped<String>? orderId,
    Wrapped<String>? transactionId,
  }) {
    return CompletePurchaseDto(
      orderId: (orderId != null ? orderId.value : this.orderId),
      transactionId: (transactionId != null
          ? transactionId.value
          : this.transactionId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductDto {
  const ProductDto({
    required this.id,
    required this.price,
    required this.numberOfTickets,
    required this.name,
    required this.description,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  static const toJsonFactory = _$ProductDtoToJson;
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'price', includeIfNull: true)
  final int price;
  @JsonKey(name: 'numberOfTickets', includeIfNull: true)
  final int numberOfTickets;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'description', includeIfNull: true)
  final String description;
  static const fromJsonFactory = _$ProductDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.numberOfTickets, numberOfTickets) ||
                const DeepCollectionEquality().equals(
                  other.numberOfTickets,
                  numberOfTickets,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(numberOfTickets) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $ProductDtoExtension on ProductDto {
  ProductDto copyWith({
    int? id,
    int? price,
    int? numberOfTickets,
    String? name,
    String? description,
  }) {
    return ProductDto(
      id: id ?? this.id,
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  ProductDto copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<int>? price,
    Wrapped<int>? numberOfTickets,
    Wrapped<String>? name,
    Wrapped<String>? description,
  }) {
    return ProductDto(
      id: (id != null ? id.value : this.id),
      price: (price != null ? price.value : this.price),
      numberOfTickets: (numberOfTickets != null
          ? numberOfTickets.value
          : this.numberOfTickets),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProgrammeDto {
  const ProgrammeDto({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  factory ProgrammeDto.fromJson(Map<String, dynamic> json) =>
      _$ProgrammeDtoFromJson(json);

  static const toJsonFactory = _$ProgrammeDtoToJson;
  Map<String, dynamic> toJson() => _$ProgrammeDtoToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'shortName', includeIfNull: true)
  final String shortName;
  @JsonKey(name: 'fullName', includeIfNull: true)
  final String fullName;
  static const fromJsonFactory = _$ProgrammeDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProgrammeDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.shortName, shortName) ||
                const DeepCollectionEquality().equals(
                  other.shortName,
                  shortName,
                )) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(
                  other.fullName,
                  fullName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(shortName) ^
      const DeepCollectionEquality().hash(fullName) ^
      runtimeType.hashCode;
}

extension $ProgrammeDtoExtension on ProgrammeDto {
  ProgrammeDto copyWith({int? id, String? shortName, String? fullName}) {
    return ProgrammeDto(
      id: id ?? this.id,
      shortName: shortName ?? this.shortName,
      fullName: fullName ?? this.fullName,
    );
  }

  ProgrammeDto copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? shortName,
    Wrapped<String>? fullName,
  }) {
    return ProgrammeDto(
      id: (id != null ? id.value : this.id),
      shortName: (shortName != null ? shortName.value : this.shortName),
      fullName: (fullName != null ? fullName.value : this.fullName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PurchaseDto {
  const PurchaseDto({
    required this.id,
    required this.productName,
    required this.productId,
    required this.price,
    required this.numberOfTickets,
    required this.dateCreated,
    required this.completed,
    required this.orderId,
    required this.transactionId,
  });

  factory PurchaseDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseDtoFromJson(json);

  static const toJsonFactory = _$PurchaseDtoToJson;
  Map<String, dynamic> toJson() => _$PurchaseDtoToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'price', includeIfNull: true)
  final int price;
  @JsonKey(name: 'numberOfTickets', includeIfNull: true)
  final int numberOfTickets;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'completed', includeIfNull: true)
  final bool completed;
  @JsonKey(name: 'orderId', includeIfNull: true)
  final String orderId;
  @JsonKey(name: 'transactionId', includeIfNull: true)
  final String transactionId;
  static const fromJsonFactory = _$PurchaseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PurchaseDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.numberOfTickets, numberOfTickets) ||
                const DeepCollectionEquality().equals(
                  other.numberOfTickets,
                  numberOfTickets,
                )) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality().equals(
                  other.dateCreated,
                  dateCreated,
                )) &&
            (identical(other.completed, completed) ||
                const DeepCollectionEquality().equals(
                  other.completed,
                  completed,
                )) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality().equals(
                  other.transactionId,
                  transactionId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(numberOfTickets) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(completed) ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(transactionId) ^
      runtimeType.hashCode;
}

extension $PurchaseDtoExtension on PurchaseDto {
  PurchaseDto copyWith({
    int? id,
    String? productName,
    int? productId,
    int? price,
    int? numberOfTickets,
    DateTime? dateCreated,
    bool? completed,
    String? orderId,
    String? transactionId,
  }) {
    return PurchaseDto(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      dateCreated: dateCreated ?? this.dateCreated,
      completed: completed ?? this.completed,
      orderId: orderId ?? this.orderId,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  PurchaseDto copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? productName,
    Wrapped<int>? productId,
    Wrapped<int>? price,
    Wrapped<int>? numberOfTickets,
    Wrapped<DateTime>? dateCreated,
    Wrapped<bool>? completed,
    Wrapped<String>? orderId,
    Wrapped<String>? transactionId,
  }) {
    return PurchaseDto(
      id: (id != null ? id.value : this.id),
      productName: (productName != null ? productName.value : this.productName),
      productId: (productId != null ? productId.value : this.productId),
      price: (price != null ? price.value : this.price),
      numberOfTickets: (numberOfTickets != null
          ? numberOfTickets.value
          : this.numberOfTickets),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      completed: (completed != null ? completed.value : this.completed),
      orderId: (orderId != null ? orderId.value : this.orderId),
      transactionId: (transactionId != null
          ? transactionId.value
          : this.transactionId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueProductDto {
  const IssueProductDto({
    required this.issuedBy,
    required this.userId,
    required this.productId,
  });

  factory IssueProductDto.fromJson(Map<String, dynamic> json) =>
      _$IssueProductDtoFromJson(json);

  static const toJsonFactory = _$IssueProductDtoToJson;
  Map<String, dynamic> toJson() => _$IssueProductDtoToJson(this);

  @JsonKey(name: 'issuedBy', includeIfNull: true)
  final String issuedBy;
  @JsonKey(name: 'userId', includeIfNull: true)
  final int userId;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  static const fromJsonFactory = _$IssueProductDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueProductDto &&
            (identical(other.issuedBy, issuedBy) ||
                const DeepCollectionEquality().equals(
                  other.issuedBy,
                  issuedBy,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(issuedBy) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(productId) ^
      runtimeType.hashCode;
}

extension $IssueProductDtoExtension on IssueProductDto {
  IssueProductDto copyWith({String? issuedBy, int? userId, int? productId}) {
    return IssueProductDto(
      issuedBy: issuedBy ?? this.issuedBy,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
    );
  }

  IssueProductDto copyWithWrapped({
    Wrapped<String>? issuedBy,
    Wrapped<int>? userId,
    Wrapped<int>? productId,
  }) {
    return IssueProductDto(
      issuedBy: (issuedBy != null ? issuedBy.value : this.issuedBy),
      userId: (userId != null ? userId.value : this.userId),
      productId: (productId != null ? productId.value : this.productId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TicketDto {
  const TicketDto({
    required this.id,
    required this.dateCreated,
    this.dateUsed,
    required this.productName,
  });

  factory TicketDto.fromJson(Map<String, dynamic> json) =>
      _$TicketDtoFromJson(json);

  static const toJsonFactory = _$TicketDtoToJson;
  Map<String, dynamic> toJson() => _$TicketDtoToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'dateUsed', includeIfNull: true)
  final DateTime? dateUsed;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  static const fromJsonFactory = _$TicketDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TicketDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality().equals(
                  other.dateCreated,
                  dateCreated,
                )) &&
            (identical(other.dateUsed, dateUsed) ||
                const DeepCollectionEquality().equals(
                  other.dateUsed,
                  dateUsed,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(dateUsed) ^
      const DeepCollectionEquality().hash(productName) ^
      runtimeType.hashCode;
}

extension $TicketDtoExtension on TicketDto {
  TicketDto copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateUsed,
    String? productName,
  }) {
    return TicketDto(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUsed: dateUsed ?? this.dateUsed,
      productName: productName ?? this.productName,
    );
  }

  TicketDto copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<DateTime>? dateCreated,
    Wrapped<DateTime?>? dateUsed,
    Wrapped<String>? productName,
  }) {
    return TicketDto(
      id: (id != null ? id.value : this.id),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      dateUsed: (dateUsed != null ? dateUsed.value : this.dateUsed),
      productName: (productName != null ? productName.value : this.productName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UseMultipleTicketDto {
  const UseMultipleTicketDto({required this.productIds});

  factory UseMultipleTicketDto.fromJson(Map<String, dynamic> json) =>
      _$UseMultipleTicketDtoFromJson(json);

  static const toJsonFactory = _$UseMultipleTicketDtoToJson;
  Map<String, dynamic> toJson() => _$UseMultipleTicketDtoToJson(this);

  @JsonKey(name: 'productIds', includeIfNull: true, defaultValue: <int>[])
  final List<int> productIds;
  static const fromJsonFactory = _$UseMultipleTicketDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UseMultipleTicketDto &&
            (identical(other.productIds, productIds) ||
                const DeepCollectionEquality().equals(
                  other.productIds,
                  productIds,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productIds) ^ runtimeType.hashCode;
}

extension $UseMultipleTicketDtoExtension on UseMultipleTicketDto {
  UseMultipleTicketDto copyWith({List<int>? productIds}) {
    return UseMultipleTicketDto(productIds: productIds ?? this.productIds);
  }

  UseMultipleTicketDto copyWithWrapped({Wrapped<List<int>>? productIds}) {
    return UseMultipleTicketDto(
      productIds: (productIds != null ? productIds.value : this.productIds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UsedTicketResponse {
  const UsedTicketResponse({
    required this.id,
    required this.dateCreated,
    required this.dateUsed,
    required this.productName,
    this.menuItemName,
  });

  factory UsedTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$UsedTicketResponseFromJson(json);

  static const toJsonFactory = _$UsedTicketResponseToJson;
  Map<String, dynamic> toJson() => _$UsedTicketResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'dateUsed', includeIfNull: true)
  final DateTime dateUsed;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  @JsonKey(name: 'menuItemName', includeIfNull: true)
  final String? menuItemName;
  static const fromJsonFactory = _$UsedTicketResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UsedTicketResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality().equals(
                  other.dateCreated,
                  dateCreated,
                )) &&
            (identical(other.dateUsed, dateUsed) ||
                const DeepCollectionEquality().equals(
                  other.dateUsed,
                  dateUsed,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.menuItemName, menuItemName) ||
                const DeepCollectionEquality().equals(
                  other.menuItemName,
                  menuItemName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(dateUsed) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(menuItemName) ^
      runtimeType.hashCode;
}

extension $UsedTicketResponseExtension on UsedTicketResponse {
  UsedTicketResponse copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateUsed,
    String? productName,
    String? menuItemName,
  }) {
    return UsedTicketResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUsed: dateUsed ?? this.dateUsed,
      productName: productName ?? this.productName,
      menuItemName: menuItemName ?? this.menuItemName,
    );
  }

  UsedTicketResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<DateTime>? dateCreated,
    Wrapped<DateTime>? dateUsed,
    Wrapped<String>? productName,
    Wrapped<String?>? menuItemName,
  }) {
    return UsedTicketResponse(
      id: (id != null ? id.value : this.id),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      dateUsed: (dateUsed != null ? dateUsed.value : this.dateUsed),
      productName: (productName != null ? productName.value : this.productName),
      menuItemName: (menuItemName != null
          ? menuItemName.value
          : this.menuItemName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UseTicketDto {
  const UseTicketDto({required this.productId});

  factory UseTicketDto.fromJson(Map<String, dynamic> json) =>
      _$UseTicketDtoFromJson(json);

  static const toJsonFactory = _$UseTicketDtoToJson;
  Map<String, dynamic> toJson() => _$UseTicketDtoToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  static const fromJsonFactory = _$UseTicketDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UseTicketDto &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^ runtimeType.hashCode;
}

extension $UseTicketDtoExtension on UseTicketDto {
  UseTicketDto copyWith({int? productId}) {
    return UseTicketDto(productId: productId ?? this.productId);
  }

  UseTicketDto copyWithWrapped({Wrapped<int>? productId}) {
    return UseTicketDto(
      productId: (productId != null ? productId.value : this.productId),
    );
  }
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
