// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffeecard_api_v2.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponseDto _$MessageResponseDtoFromJson(Map<String, dynamic> json) =>
    MessageResponseDto(message: json['message'] as String?);

Map<String, dynamic> _$MessageResponseDtoToJson(MessageResponseDto instance) =>
    <String, dynamic>{'message': instance.message};

RegisterAccountRequest _$RegisterAccountRequestFromJson(
  Map<String, dynamic> json,
) => RegisterAccountRequest(
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  programmeId: (json['programmeId'] as num).toInt(),
);

Map<String, dynamic> _$RegisterAccountRequestToJson(
  RegisterAccountRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'programmeId': instance.programmeId,
};

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) =>
    ApiError(message: json['message'] as String?);

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
  'message': instance.message,
};

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  privacyActivated: json['privacyActivated'] as bool,
  role: json['role'],
  programme: json['programme'],
  rankAllTime: (json['rankAllTime'] as num).toInt(),
  rankSemester: (json['rankSemester'] as num).toInt(),
  rankMonth: (json['rankMonth'] as num).toInt(),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'privacyActivated': instance.privacyActivated,
      'role': instance.role,
      'programme': instance.programme,
      'rankAllTime': instance.rankAllTime,
      'rankSemester': instance.rankSemester,
      'rankMonth': instance.rankMonth,
    };

ProgrammeResponse _$ProgrammeResponseFromJson(Map<String, dynamic> json) =>
    ProgrammeResponse(
      id: (json['id'] as num).toInt(),
      shortName: json['shortName'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$ProgrammeResponseToJson(ProgrammeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortName': instance.shortName,
      'fullName': instance.fullName,
    };

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
      privacyActivated: json['privacyActivated'] as bool?,
      programmeId: (json['programmeId'] as num?)?.toInt(),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'privacyActivated': instance.privacyActivated,
      'programmeId': instance.programmeId,
      'password': instance.password,
    };

EmailExistsResponse _$EmailExistsResponseFromJson(Map<String, dynamic> json) =>
    EmailExistsResponse(emailExists: json['emailExists'] as bool);

Map<String, dynamic> _$EmailExistsResponseToJson(
  EmailExistsResponse instance,
) => <String, dynamic>{'emailExists': instance.emailExists};

EmailExistsRequest _$EmailExistsRequestFromJson(Map<String, dynamic> json) =>
    EmailExistsRequest(email: json['email'] as String);

Map<String, dynamic> _$EmailExistsRequestToJson(EmailExistsRequest instance) =>
    <String, dynamic>{'email': instance.email};

UpdateUserGroupRequest _$UpdateUserGroupRequestFromJson(
  Map<String, dynamic> json,
) => UpdateUserGroupRequest(userGroup: json['userGroup']);

Map<String, dynamic> _$UpdateUserGroupRequestToJson(
  UpdateUserGroupRequest instance,
) => <String, dynamic>{'userGroup': instance.userGroup};

ResendAccountVerificationEmailRequest
_$ResendAccountVerificationEmailRequestFromJson(Map<String, dynamic> json) =>
    ResendAccountVerificationEmailRequest(email: json['email'] as String);

Map<String, dynamic> _$ResendAccountVerificationEmailRequestToJson(
  ResendAccountVerificationEmailRequest instance,
) => <String, dynamic>{'email': instance.email};

UserSearchResponse _$UserSearchResponseFromJson(Map<String, dynamic> json) =>
    UserSearchResponse(
      totalUsers: (json['totalUsers'] as num).toInt(),
      users:
          (json['users'] as List<dynamic>?)
              ?.map(
                (e) => SimpleUserResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserSearchResponseToJson(UserSearchResponse instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'users': instance.users.map((e) => e.toJson()).toList(),
    };

SimpleUserResponse _$SimpleUserResponseFromJson(Map<String, dynamic> json) =>
    SimpleUserResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      userGroup: json['userGroup'],
      state: json['state'],
    );

Map<String, dynamic> _$SimpleUserResponseToJson(SimpleUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'userGroup': instance.userGroup,
      'state': instance.state,
    };

UserLoginRequest _$UserLoginRequestFromJson(Map<String, dynamic> json) =>
    UserLoginRequest(
      email: json['email'] as String,
      loginType: json['loginType'],
    );

Map<String, dynamic> _$UserLoginRequestToJson(UserLoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'loginType': instance.loginType};

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse(
      jwt: json['jwt'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'jwt': instance.jwt,
      'refreshToken': instance.refreshToken,
    };

TokenLoginRequest _$TokenLoginRequestFromJson(Map<String, dynamic> json) =>
    TokenLoginRequest(token: json['token'] as String);

Map<String, dynamic> _$TokenLoginRequestToJson(TokenLoginRequest instance) =>
    <String, dynamic>{'token': instance.token};

UnusedClipsResponse _$UnusedClipsResponseFromJson(Map<String, dynamic> json) =>
    UnusedClipsResponse(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      ticketsLeft: (json['ticketsLeft'] as num?)?.toInt(),
      unusedPurchasesValue: (json['unusedPurchasesValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UnusedClipsResponseToJson(
  UnusedClipsResponse instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'productName': instance.productName,
  'ticketsLeft': instance.ticketsLeft,
  'unusedPurchasesValue': instance.unusedPurchasesValue,
};

UnusedClipsRequest _$UnusedClipsRequestFromJson(Map<String, dynamic> json) =>
    UnusedClipsRequest(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$UnusedClipsRequestToJson(UnusedClipsRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) =>
    AppConfig(environmentType: json['environmentType']);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'environmentType': instance.environmentType,
};

ServiceHealthResponse _$ServiceHealthResponseFromJson(
  Map<String, dynamic> json,
) => ServiceHealthResponse(
  mobilePay: json['mobilePay'] as bool?,
  database: json['database'] as bool?,
);

Map<String, dynamic> _$ServiceHealthResponseToJson(
  ServiceHealthResponse instance,
) => <String, dynamic>{
  'mobilePay': instance.mobilePay,
  'database': instance.database,
};

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) =>
    LeaderboardEntry(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      rank: (json['rank'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LeaderboardEntryToJson(LeaderboardEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rank': instance.rank,
      'score': instance.score,
    };

MenuItemResponse _$MenuItemResponseFromJson(Map<String, dynamic> json) =>
    MenuItemResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$MenuItemResponseToJson(MenuItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
    };

AddMenuItemRequest _$AddMenuItemRequestFromJson(Map<String, dynamic> json) =>
    AddMenuItemRequest(name: json['name'] as String);

Map<String, dynamic> _$AddMenuItemRequestToJson(AddMenuItemRequest instance) =>
    <String, dynamic>{'name': instance.name};

UpdateMenuItemRequest _$UpdateMenuItemRequestFromJson(
  Map<String, dynamic> json,
) => UpdateMenuItemRequest(
  name: json['name'] as String,
  active: json['active'] as bool,
);

Map<String, dynamic> _$UpdateMenuItemRequestToJson(
  UpdateMenuItemRequest instance,
) => <String, dynamic>{'name': instance.name, 'active': instance.active};

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      numberOfTickets: (json['numberOfTickets'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      isPerk: json['isPerk'] as bool,
      visible: json['visible'] as bool,
      allowedUserGroups: userGroupListFromJson(
        json['allowedUserGroups'] as List?,
      ),
      eligibleMenuItems:
          (json['eligibleMenuItems'] as List<dynamic>?)
              ?.map((e) => MenuItemResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'numberOfTickets': instance.numberOfTickets,
      'name': instance.name,
      'description': instance.description,
      'isPerk': instance.isPerk,
      'visible': instance.visible,
      'allowedUserGroups': userGroupListToJson(instance.allowedUserGroups),
      'eligibleMenuItems': instance.eligibleMenuItems
          ?.map((e) => e.toJson())
          .toList(),
    };

AddProductRequest _$AddProductRequestFromJson(Map<String, dynamic> json) =>
    AddProductRequest(
      price: (json['price'] as num).toInt(),
      numberOfTickets: (json['numberOfTickets'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      visible: json['visible'] as bool? ?? true,
      allowedUserGroups: userGroupListFromJson(
        json['allowedUserGroups'] as List?,
      ),
      menuItemIds:
          (json['menuItemIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$AddProductRequestToJson(AddProductRequest instance) =>
    <String, dynamic>{
      'price': instance.price,
      'numberOfTickets': instance.numberOfTickets,
      'name': instance.name,
      'description': instance.description,
      'visible': instance.visible,
      'allowedUserGroups': userGroupListToJson(instance.allowedUserGroups),
      'menuItemIds': instance.menuItemIds,
    };

UpdateProductRequest _$UpdateProductRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProductRequest(
  price: (json['price'] as num).toInt(),
  numberOfTickets: (json['numberOfTickets'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  visible: json['visible'] as bool? ?? true,
  allowedUserGroups: userGroupListFromJson(json['allowedUserGroups'] as List?),
  menuItemIds:
      (json['menuItemIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
);

Map<String, dynamic> _$UpdateProductRequestToJson(
  UpdateProductRequest instance,
) => <String, dynamic>{
  'price': instance.price,
  'numberOfTickets': instance.numberOfTickets,
  'name': instance.name,
  'description': instance.description,
  'visible': instance.visible,
  'allowedUserGroups': userGroupListToJson(instance.allowedUserGroups),
  'menuItemIds': instance.menuItemIds,
};

SimplePurchaseResponse _$SimplePurchaseResponseFromJson(
  Map<String, dynamic> json,
) => SimplePurchaseResponse(
  id: (json['id'] as num).toInt(),
  dateCreated: DateTime.parse(json['dateCreated'] as String),
  productId: (json['productId'] as num).toInt(),
  productName: json['productName'] as String,
  numberOfTickets: (json['numberOfTickets'] as num).toInt(),
  totalAmount: (json['totalAmount'] as num).toInt(),
  purchaseStatus: json['purchaseStatus'],
);

Map<String, dynamic> _$SimplePurchaseResponseToJson(
  SimplePurchaseResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'dateCreated': instance.dateCreated.toIso8601String(),
  'productId': instance.productId,
  'productName': instance.productName,
  'numberOfTickets': instance.numberOfTickets,
  'totalAmount': instance.totalAmount,
  'purchaseStatus': instance.purchaseStatus,
};

SinglePurchaseResponse _$SinglePurchaseResponseFromJson(
  Map<String, dynamic> json,
) => SinglePurchaseResponse(
  id: (json['id'] as num).toInt(),
  dateCreated: DateTime.parse(json['dateCreated'] as String),
  productId: (json['productId'] as num).toInt(),
  totalAmount: (json['totalAmount'] as num).toInt(),
  purchaseStatus: json['purchaseStatus'],
  paymentDetails: json['paymentDetails'],
);

Map<String, dynamic> _$SinglePurchaseResponseToJson(
  SinglePurchaseResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'dateCreated': instance.dateCreated.toIso8601String(),
  'productId': instance.productId,
  'totalAmount': instance.totalAmount,
  'purchaseStatus': instance.purchaseStatus,
  'paymentDetails': instance.paymentDetails,
};

PaymentDetails _$PaymentDetailsFromJson(Map<String, dynamic> json) =>
    PaymentDetails(
      paymentType: json['paymentType'],
      orderId: json['orderId'] as String,
      discriminator: json['discriminator'] as String,
    );

Map<String, dynamic> _$PaymentDetailsToJson(PaymentDetails instance) =>
    <String, dynamic>{
      'paymentType': instance.paymentType,
      'orderId': instance.orderId,
      'discriminator': instance.discriminator,
    };

MobilePayPaymentDetails _$MobilePayPaymentDetailsFromJson(
  Map<String, dynamic> json,
) => MobilePayPaymentDetails(
  mobilePayAppRedirectUri: json['mobilePayAppRedirectUri'] as String,
  paymentId: json['paymentId'] as String,
  paymentType: json['paymentType'],
  orderId: json['orderId'] as String,
  discriminator: json['discriminator'] as String,
);

Map<String, dynamic> _$MobilePayPaymentDetailsToJson(
  MobilePayPaymentDetails instance,
) => <String, dynamic>{
  'mobilePayAppRedirectUri': instance.mobilePayAppRedirectUri,
  'paymentId': instance.paymentId,
  'paymentType': instance.paymentType,
  'orderId': instance.orderId,
  'discriminator': instance.discriminator,
};

FreePurchasePaymentDetails _$FreePurchasePaymentDetailsFromJson(
  Map<String, dynamic> json,
) => FreePurchasePaymentDetails(
  paymentType: json['paymentType'],
  orderId: json['orderId'] as String,
  discriminator: json['discriminator'] as String,
);

Map<String, dynamic> _$FreePurchasePaymentDetailsToJson(
  FreePurchasePaymentDetails instance,
) => <String, dynamic>{
  'paymentType': instance.paymentType,
  'orderId': instance.orderId,
  'discriminator': instance.discriminator,
};

InitiatePurchaseResponse _$InitiatePurchaseResponseFromJson(
  Map<String, dynamic> json,
) => InitiatePurchaseResponse(
  id: (json['id'] as num).toInt(),
  dateCreated: DateTime.parse(json['dateCreated'] as String),
  productId: (json['productId'] as num).toInt(),
  productName: json['productName'] as String,
  totalAmount: (json['totalAmount'] as num).toInt(),
  purchaseStatus: json['purchaseStatus'],
  paymentDetails: json['paymentDetails'],
);

Map<String, dynamic> _$InitiatePurchaseResponseToJson(
  InitiatePurchaseResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'dateCreated': instance.dateCreated.toIso8601String(),
  'productId': instance.productId,
  'productName': instance.productName,
  'totalAmount': instance.totalAmount,
  'purchaseStatus': instance.purchaseStatus,
  'paymentDetails': instance.paymentDetails,
};

InitiatePurchaseRequest _$InitiatePurchaseRequestFromJson(
  Map<String, dynamic> json,
) => InitiatePurchaseRequest(
  productId: (json['productId'] as num).toInt(),
  paymentType: json['paymentType'],
);

Map<String, dynamic> _$InitiatePurchaseRequestToJson(
  InitiatePurchaseRequest instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'paymentType': instance.paymentType,
};

TicketResponse _$TicketResponseFromJson(Map<String, dynamic> json) =>
    TicketResponse(
      id: (json['id'] as num).toInt(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateUsed: json['dateUsed'] == null
          ? null
          : DateTime.parse(json['dateUsed'] as String),
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String,
      usedOnMenuItemName: json['usedOnMenuItemName'] as String?,
    );

Map<String, dynamic> _$TicketResponseToJson(TicketResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'dateUsed': instance.dateUsed?.toIso8601String(),
      'productId': instance.productId,
      'productName': instance.productName,
      'usedOnMenuItemName': instance.usedOnMenuItemName,
    };

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

UseTicketRequest _$UseTicketRequestFromJson(Map<String, dynamic> json) =>
    UseTicketRequest(
      productId: (json['productId'] as num).toInt(),
      menuItemId: (json['menuItemId'] as num).toInt(),
    );

Map<String, dynamic> _$UseTicketRequestToJson(UseTicketRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'menuItemId': instance.menuItemId,
    };

IssueVoucherResponse _$IssueVoucherResponseFromJson(
  Map<String, dynamic> json,
) => IssueVoucherResponse(
  voucherCode: json['voucherCode'] as String,
  productId: (json['productId'] as num).toInt(),
  productName: json['productName'] as String,
  issuedAt: DateTime.parse(json['issuedAt'] as String),
);

Map<String, dynamic> _$IssueVoucherResponseToJson(
  IssueVoucherResponse instance,
) => <String, dynamic>{
  'voucherCode': instance.voucherCode,
  'productId': instance.productId,
  'productName': instance.productName,
  'issuedAt': instance.issuedAt.toIso8601String(),
};

IssueVoucherRequest _$IssueVoucherRequestFromJson(Map<String, dynamic> json) =>
    IssueVoucherRequest(
      productId: (json['productId'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      voucherPrefix: json['voucherPrefix'] as String,
      description: json['description'] as String,
      requester: json['requester'] as String,
    );

Map<String, dynamic> _$IssueVoucherRequestToJson(
  IssueVoucherRequest instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'amount': instance.amount,
  'voucherPrefix': instance.voucherPrefix,
  'description': instance.description,
  'requester': instance.requester,
};

WebhookUpdateUserGroupRequest _$WebhookUpdateUserGroupRequestFromJson(
  Map<String, dynamic> json,
) => WebhookUpdateUserGroupRequest(
  privilegedUsers:
      (json['privilegedUsers'] as List<dynamic>?)
          ?.map((e) => AccountUserGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$WebhookUpdateUserGroupRequestToJson(
  WebhookUpdateUserGroupRequest instance,
) => <String, dynamic>{
  'privilegedUsers': instance.privilegedUsers.map((e) => e.toJson()).toList(),
};

AccountUserGroup _$AccountUserGroupFromJson(Map<String, dynamic> json) =>
    AccountUserGroup(
      accountId: (json['accountId'] as num).toInt(),
      userGroup: json['userGroup'],
    );

Map<String, dynamic> _$AccountUserGroupToJson(AccountUserGroup instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'userGroup': instance.userGroup,
    };
