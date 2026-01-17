// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffeecard_api_v1.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponseDto _$MessageResponseDtoFromJson(Map<String, dynamic> json) =>
    MessageResponseDto(message: json['message'] as String?);

Map<String, dynamic> _$MessageResponseDtoToJson(MessageResponseDto instance) =>
    <String, dynamic>{'message': instance.message};

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) => RegisterDto(
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };

TokenDto _$TokenDtoFromJson(Map<String, dynamic> json) =>
    TokenDto(token: json['token'] as String?);

Map<String, dynamic> _$TokenDtoToJson(TokenDto instance) => <String, dynamic>{
  'token': instance.token,
};

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) =>
    ApiError(message: json['message'] as String?);

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
  'message': instance.message,
};

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
  email: json['email'] as String,
  password: json['password'] as String,
  version: json['version'] as String,
);

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'version': instance.version,
};

UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) =>
    UpdateUserDto(
      name: json['name'] as String?,
      email: json['email'] as String?,
      privacyActivated: json['privacyActivated'] as bool?,
      programmeId: (json['programmeId'] as num?)?.toInt(),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'privacyActivated': instance.privacyActivated,
      'programmeId': instance.programmeId,
      'password': instance.password,
    };

EmailDto _$EmailDtoFromJson(Map<String, dynamic> json) =>
    EmailDto(email: json['email'] as String);

Map<String, dynamic> _$EmailDtoToJson(EmailDto instance) => <String, dynamic>{
  'email': instance.email,
};

CoffeeCardDto _$CoffeeCardDtoFromJson(Map<String, dynamic> json) =>
    CoffeeCardDto(
      productId: (json['productId'] as num).toInt(),
      name: json['name'] as String,
      ticketsLeft: (json['ticketsLeft'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CoffeeCardDtoToJson(CoffeeCardDto instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'ticketsLeft': instance.ticketsLeft,
      'price': instance.price,
      'quantity': instance.quantity,
    };

InitiatePurchaseDto _$InitiatePurchaseDtoFromJson(Map<String, dynamic> json) =>
    InitiatePurchaseDto(productId: (json['productId'] as num).toInt());

Map<String, dynamic> _$InitiatePurchaseDtoToJson(
  InitiatePurchaseDto instance,
) => <String, dynamic>{'productId': instance.productId};

CompletePurchaseDto _$CompletePurchaseDtoFromJson(Map<String, dynamic> json) =>
    CompletePurchaseDto(
      orderId: json['orderId'] as String,
      transactionId: json['transactionId'] as String,
    );

Map<String, dynamic> _$CompletePurchaseDtoToJson(
  CompletePurchaseDto instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'transactionId': instance.transactionId,
};

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
  id: (json['id'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  numberOfTickets: (json['numberOfTickets'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'numberOfTickets': instance.numberOfTickets,
      'name': instance.name,
      'description': instance.description,
    };

ProgrammeDto _$ProgrammeDtoFromJson(Map<String, dynamic> json) => ProgrammeDto(
  id: (json['id'] as num).toInt(),
  shortName: json['shortName'] as String,
  fullName: json['fullName'] as String,
);

Map<String, dynamic> _$ProgrammeDtoToJson(ProgrammeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortName': instance.shortName,
      'fullName': instance.fullName,
    };

PurchaseDto _$PurchaseDtoFromJson(Map<String, dynamic> json) => PurchaseDto(
  id: (json['id'] as num).toInt(),
  productName: json['productName'] as String,
  productId: (json['productId'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  numberOfTickets: (json['numberOfTickets'] as num).toInt(),
  dateCreated: DateTime.parse(json['dateCreated'] as String),
  completed: json['completed'] as bool,
  orderId: json['orderId'] as String,
  transactionId: json['transactionId'] as String,
);

Map<String, dynamic> _$PurchaseDtoToJson(PurchaseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'productId': instance.productId,
      'price': instance.price,
      'numberOfTickets': instance.numberOfTickets,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'completed': instance.completed,
      'orderId': instance.orderId,
      'transactionId': instance.transactionId,
    };

IssueProductDto _$IssueProductDtoFromJson(Map<String, dynamic> json) =>
    IssueProductDto(
      issuedBy: json['issuedBy'] as String,
      userId: (json['userId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
    );

Map<String, dynamic> _$IssueProductDtoToJson(IssueProductDto instance) =>
    <String, dynamic>{
      'issuedBy': instance.issuedBy,
      'userId': instance.userId,
      'productId': instance.productId,
    };

TicketDto _$TicketDtoFromJson(Map<String, dynamic> json) => TicketDto(
  id: (json['id'] as num).toInt(),
  dateCreated: DateTime.parse(json['dateCreated'] as String),
  dateUsed: json['dateUsed'] == null
      ? null
      : DateTime.parse(json['dateUsed'] as String),
  productName: json['productName'] as String,
);

Map<String, dynamic> _$TicketDtoToJson(TicketDto instance) => <String, dynamic>{
  'id': instance.id,
  'dateCreated': instance.dateCreated.toIso8601String(),
  'dateUsed': instance.dateUsed?.toIso8601String(),
  'productName': instance.productName,
};

UseMultipleTicketDto _$UseMultipleTicketDtoFromJson(
  Map<String, dynamic> json,
) => UseMultipleTicketDto(
  productIds:
      (json['productIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
);

Map<String, dynamic> _$UseMultipleTicketDtoToJson(
  UseMultipleTicketDto instance,
) => <String, dynamic>{'productIds': instance.productIds};

UsedTicketResponse _$UsedTicketResponseFromJson(Map<String, dynamic> json) =>
    UsedTicketResponse(
      id: (json['id'] as num).toInt(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateUsed: DateTime.parse(json['dateUsed'] as String),
      productName: json['productName'] as String,
      menuItemName: json['menuItemName'] as String?,
    );

Map<String, dynamic> _$UsedTicketResponseToJson(UsedTicketResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'dateUsed': instance.dateUsed.toIso8601String(),
      'productName': instance.productName,
      'menuItemName': instance.menuItemName,
    };

UseTicketDto _$UseTicketDtoFromJson(Map<String, dynamic> json) =>
    UseTicketDto(productId: (json['productId'] as num).toInt());

Map<String, dynamic> _$UseTicketDtoToJson(UseTicketDto instance) =>
    <String, dynamic>{'productId': instance.productId};
