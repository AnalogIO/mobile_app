// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'coffeecard_api_v2.enums.swagger.dart' as enums;

part 'coffeecard_api_v2.models.swagger.g.dart';

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
class RegisterAccountRequest {
  const RegisterAccountRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.programmeId,
  });

  factory RegisterAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterAccountRequestFromJson(json);

  static const toJsonFactory = _$RegisterAccountRequestToJson;
  Map<String, dynamic> toJson() => _$RegisterAccountRequestToJson(this);

  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  @JsonKey(name: 'password', includeIfNull: true)
  final String password;
  @JsonKey(name: 'programmeId', includeIfNull: true)
  final int programmeId;
  static const fromJsonFactory = _$RegisterAccountRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RegisterAccountRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.programmeId, programmeId) ||
                const DeepCollectionEquality().equals(
                  other.programmeId,
                  programmeId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(programmeId) ^
      runtimeType.hashCode;
}

extension $RegisterAccountRequestExtension on RegisterAccountRequest {
  RegisterAccountRequest copyWith({
    String? name,
    String? email,
    String? password,
    int? programmeId,
  }) {
    return RegisterAccountRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      programmeId: programmeId ?? this.programmeId,
    );
  }

  RegisterAccountRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? email,
    Wrapped<String>? password,
    Wrapped<int>? programmeId,
  }) {
    return RegisterAccountRequest(
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
      programmeId: (programmeId != null ? programmeId.value : this.programmeId),
    );
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
class UserResponse {
  const UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.privacyActivated,
    required this.role,
    required this.programme,
    required this.rankAllTime,
    required this.rankSemester,
    required this.rankMonth,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  static const toJsonFactory = _$UserResponseToJson;
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  @JsonKey(name: 'privacyActivated', includeIfNull: true)
  final bool privacyActivated;
  @JsonKey(name: 'role', includeIfNull: true)
  final dynamic role;
  @JsonKey(name: 'programme', includeIfNull: true)
  final dynamic programme;
  @JsonKey(name: 'rankAllTime', includeIfNull: true)
  final int rankAllTime;
  @JsonKey(name: 'rankSemester', includeIfNull: true)
  final int rankSemester;
  @JsonKey(name: 'rankMonth', includeIfNull: true)
  final int rankMonth;
  static const fromJsonFactory = _$UserResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.privacyActivated, privacyActivated) ||
                const DeepCollectionEquality().equals(
                  other.privacyActivated,
                  privacyActivated,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.programme, programme) ||
                const DeepCollectionEquality().equals(
                  other.programme,
                  programme,
                )) &&
            (identical(other.rankAllTime, rankAllTime) ||
                const DeepCollectionEquality().equals(
                  other.rankAllTime,
                  rankAllTime,
                )) &&
            (identical(other.rankSemester, rankSemester) ||
                const DeepCollectionEquality().equals(
                  other.rankSemester,
                  rankSemester,
                )) &&
            (identical(other.rankMonth, rankMonth) ||
                const DeepCollectionEquality().equals(
                  other.rankMonth,
                  rankMonth,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(privacyActivated) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(programme) ^
      const DeepCollectionEquality().hash(rankAllTime) ^
      const DeepCollectionEquality().hash(rankSemester) ^
      const DeepCollectionEquality().hash(rankMonth) ^
      runtimeType.hashCode;
}

extension $UserResponseExtension on UserResponse {
  UserResponse copyWith({
    int? id,
    String? name,
    String? email,
    bool? privacyActivated,
    dynamic role,
    dynamic programme,
    int? rankAllTime,
    int? rankSemester,
    int? rankMonth,
  }) {
    return UserResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      privacyActivated: privacyActivated ?? this.privacyActivated,
      role: role ?? this.role,
      programme: programme ?? this.programme,
      rankAllTime: rankAllTime ?? this.rankAllTime,
      rankSemester: rankSemester ?? this.rankSemester,
      rankMonth: rankMonth ?? this.rankMonth,
    );
  }

  UserResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? name,
    Wrapped<String>? email,
    Wrapped<bool>? privacyActivated,
    Wrapped<dynamic>? role,
    Wrapped<dynamic>? programme,
    Wrapped<int>? rankAllTime,
    Wrapped<int>? rankSemester,
    Wrapped<int>? rankMonth,
  }) {
    return UserResponse(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      privacyActivated: (privacyActivated != null
          ? privacyActivated.value
          : this.privacyActivated),
      role: (role != null ? role.value : this.role),
      programme: (programme != null ? programme.value : this.programme),
      rankAllTime: (rankAllTime != null ? rankAllTime.value : this.rankAllTime),
      rankSemester: (rankSemester != null
          ? rankSemester.value
          : this.rankSemester),
      rankMonth: (rankMonth != null ? rankMonth.value : this.rankMonth),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProgrammeResponse {
  const ProgrammeResponse({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  factory ProgrammeResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgrammeResponseFromJson(json);

  static const toJsonFactory = _$ProgrammeResponseToJson;
  Map<String, dynamic> toJson() => _$ProgrammeResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'shortName', includeIfNull: true)
  final String shortName;
  @JsonKey(name: 'fullName', includeIfNull: true)
  final String fullName;
  static const fromJsonFactory = _$ProgrammeResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProgrammeResponse &&
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

extension $ProgrammeResponseExtension on ProgrammeResponse {
  ProgrammeResponse copyWith({int? id, String? shortName, String? fullName}) {
    return ProgrammeResponse(
      id: id ?? this.id,
      shortName: shortName ?? this.shortName,
      fullName: fullName ?? this.fullName,
    );
  }

  ProgrammeResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? shortName,
    Wrapped<String>? fullName,
  }) {
    return ProgrammeResponse(
      id: (id != null ? id.value : this.id),
      shortName: (shortName != null ? shortName.value : this.shortName),
      fullName: (fullName != null ? fullName.value : this.fullName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateUserRequest {
  const UpdateUserRequest({
    this.name,
    this.email,
    this.privacyActivated,
    this.programmeId,
    this.password,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  static const toJsonFactory = _$UpdateUserRequestToJson;
  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);

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
  static const fromJsonFactory = _$UpdateUserRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateUserRequest &&
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

extension $UpdateUserRequestExtension on UpdateUserRequest {
  UpdateUserRequest copyWith({
    String? name,
    String? email,
    bool? privacyActivated,
    int? programmeId,
    String? password,
  }) {
    return UpdateUserRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      privacyActivated: privacyActivated ?? this.privacyActivated,
      programmeId: programmeId ?? this.programmeId,
      password: password ?? this.password,
    );
  }

  UpdateUserRequest copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? email,
    Wrapped<bool?>? privacyActivated,
    Wrapped<int?>? programmeId,
    Wrapped<String?>? password,
  }) {
    return UpdateUserRequest(
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
class EmailExistsResponse {
  const EmailExistsResponse({required this.emailExists});

  factory EmailExistsResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailExistsResponseFromJson(json);

  static const toJsonFactory = _$EmailExistsResponseToJson;
  Map<String, dynamic> toJson() => _$EmailExistsResponseToJson(this);

  @JsonKey(name: 'emailExists', includeIfNull: true)
  final bool emailExists;
  static const fromJsonFactory = _$EmailExistsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EmailExistsResponse &&
            (identical(other.emailExists, emailExists) ||
                const DeepCollectionEquality().equals(
                  other.emailExists,
                  emailExists,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(emailExists) ^ runtimeType.hashCode;
}

extension $EmailExistsResponseExtension on EmailExistsResponse {
  EmailExistsResponse copyWith({bool? emailExists}) {
    return EmailExistsResponse(emailExists: emailExists ?? this.emailExists);
  }

  EmailExistsResponse copyWithWrapped({Wrapped<bool>? emailExists}) {
    return EmailExistsResponse(
      emailExists: (emailExists != null ? emailExists.value : this.emailExists),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EmailExistsRequest {
  const EmailExistsRequest({required this.email});

  factory EmailExistsRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailExistsRequestFromJson(json);

  static const toJsonFactory = _$EmailExistsRequestToJson;
  Map<String, dynamic> toJson() => _$EmailExistsRequestToJson(this);

  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  static const fromJsonFactory = _$EmailExistsRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EmailExistsRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $EmailExistsRequestExtension on EmailExistsRequest {
  EmailExistsRequest copyWith({String? email}) {
    return EmailExistsRequest(email: email ?? this.email);
  }

  EmailExistsRequest copyWithWrapped({Wrapped<String>? email}) {
    return EmailExistsRequest(
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateUserGroupRequest {
  const UpdateUserGroupRequest({required this.userGroup});

  factory UpdateUserGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserGroupRequestFromJson(json);

  static const toJsonFactory = _$UpdateUserGroupRequestToJson;
  Map<String, dynamic> toJson() => _$UpdateUserGroupRequestToJson(this);

  @JsonKey(name: 'userGroup', includeIfNull: true)
  final dynamic userGroup;
  static const fromJsonFactory = _$UpdateUserGroupRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateUserGroupRequest &&
            (identical(other.userGroup, userGroup) ||
                const DeepCollectionEquality().equals(
                  other.userGroup,
                  userGroup,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userGroup) ^ runtimeType.hashCode;
}

extension $UpdateUserGroupRequestExtension on UpdateUserGroupRequest {
  UpdateUserGroupRequest copyWith({dynamic userGroup}) {
    return UpdateUserGroupRequest(userGroup: userGroup ?? this.userGroup);
  }

  UpdateUserGroupRequest copyWithWrapped({Wrapped<dynamic>? userGroup}) {
    return UpdateUserGroupRequest(
      userGroup: (userGroup != null ? userGroup.value : this.userGroup),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ResendAccountVerificationEmailRequest {
  const ResendAccountVerificationEmailRequest({required this.email});

  factory ResendAccountVerificationEmailRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$ResendAccountVerificationEmailRequestFromJson(json);

  static const toJsonFactory = _$ResendAccountVerificationEmailRequestToJson;
  Map<String, dynamic> toJson() =>
      _$ResendAccountVerificationEmailRequestToJson(this);

  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  static const fromJsonFactory =
      _$ResendAccountVerificationEmailRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ResendAccountVerificationEmailRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $ResendAccountVerificationEmailRequestExtension
    on ResendAccountVerificationEmailRequest {
  ResendAccountVerificationEmailRequest copyWith({String? email}) {
    return ResendAccountVerificationEmailRequest(email: email ?? this.email);
  }

  ResendAccountVerificationEmailRequest copyWithWrapped({
    Wrapped<String>? email,
  }) {
    return ResendAccountVerificationEmailRequest(
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserSearchResponse {
  const UserSearchResponse({required this.totalUsers, required this.users});

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResponseFromJson(json);

  static const toJsonFactory = _$UserSearchResponseToJson;
  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);

  @JsonKey(name: 'totalUsers', includeIfNull: true)
  final int totalUsers;
  @JsonKey(
    name: 'users',
    includeIfNull: true,
    defaultValue: <SimpleUserResponse>[],
  )
  final List<SimpleUserResponse> users;
  static const fromJsonFactory = _$UserSearchResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSearchResponse &&
            (identical(other.totalUsers, totalUsers) ||
                const DeepCollectionEquality().equals(
                  other.totalUsers,
                  totalUsers,
                )) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(totalUsers) ^
      const DeepCollectionEquality().hash(users) ^
      runtimeType.hashCode;
}

extension $UserSearchResponseExtension on UserSearchResponse {
  UserSearchResponse copyWith({
    int? totalUsers,
    List<SimpleUserResponse>? users,
  }) {
    return UserSearchResponse(
      totalUsers: totalUsers ?? this.totalUsers,
      users: users ?? this.users,
    );
  }

  UserSearchResponse copyWithWrapped({
    Wrapped<int>? totalUsers,
    Wrapped<List<SimpleUserResponse>>? users,
  }) {
    return UserSearchResponse(
      totalUsers: (totalUsers != null ? totalUsers.value : this.totalUsers),
      users: (users != null ? users.value : this.users),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SimpleUserResponse {
  const SimpleUserResponse({
    this.id,
    this.name,
    this.email,
    this.userGroup,
    this.state,
  });

  factory SimpleUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SimpleUserResponseFromJson(json);

  static const toJsonFactory = _$SimpleUserResponseToJson;
  Map<String, dynamic> toJson() => _$SimpleUserResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: true)
  final String? name;
  @JsonKey(name: 'email', includeIfNull: true)
  final String? email;
  @JsonKey(name: 'userGroup', includeIfNull: true)
  final dynamic userGroup;
  @JsonKey(name: 'state', includeIfNull: true)
  final dynamic state;
  static const fromJsonFactory = _$SimpleUserResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SimpleUserResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.userGroup, userGroup) ||
                const DeepCollectionEquality().equals(
                  other.userGroup,
                  userGroup,
                )) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(userGroup) ^
      const DeepCollectionEquality().hash(state) ^
      runtimeType.hashCode;
}

extension $SimpleUserResponseExtension on SimpleUserResponse {
  SimpleUserResponse copyWith({
    int? id,
    String? name,
    String? email,
    dynamic userGroup,
    dynamic state,
  }) {
    return SimpleUserResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userGroup: userGroup ?? this.userGroup,
      state: state ?? this.state,
    );
  }

  SimpleUserResponse copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? email,
    Wrapped<dynamic>? userGroup,
    Wrapped<dynamic>? state,
  }) {
    return SimpleUserResponse(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      email: (email != null ? email.value : this.email),
      userGroup: (userGroup != null ? userGroup.value : this.userGroup),
      state: (state != null ? state.value : this.state),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserLoginRequest {
  const UserLoginRequest({required this.email, required this.loginType});

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestFromJson(json);

  static const toJsonFactory = _$UserLoginRequestToJson;
  Map<String, dynamic> toJson() => _$UserLoginRequestToJson(this);

  @JsonKey(name: 'email', includeIfNull: true)
  final String email;
  @JsonKey(name: 'loginType', includeIfNull: true)
  final dynamic loginType;
  static const fromJsonFactory = _$UserLoginRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserLoginRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.loginType, loginType) ||
                const DeepCollectionEquality().equals(
                  other.loginType,
                  loginType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(loginType) ^
      runtimeType.hashCode;
}

extension $UserLoginRequestExtension on UserLoginRequest {
  UserLoginRequest copyWith({String? email, dynamic loginType}) {
    return UserLoginRequest(
      email: email ?? this.email,
      loginType: loginType ?? this.loginType,
    );
  }

  UserLoginRequest copyWithWrapped({
    Wrapped<String>? email,
    Wrapped<dynamic>? loginType,
  }) {
    return UserLoginRequest(
      email: (email != null ? email.value : this.email),
      loginType: (loginType != null ? loginType.value : this.loginType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserLoginResponse {
  const UserLoginResponse({required this.jwt, required this.refreshToken});

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  static const toJsonFactory = _$UserLoginResponseToJson;
  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);

  @JsonKey(name: 'jwt', includeIfNull: true)
  final String jwt;
  @JsonKey(name: 'refreshToken', includeIfNull: true)
  final String refreshToken;
  static const fromJsonFactory = _$UserLoginResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserLoginResponse &&
            (identical(other.jwt, jwt) ||
                const DeepCollectionEquality().equals(other.jwt, jwt)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality().equals(
                  other.refreshToken,
                  refreshToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(jwt) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      runtimeType.hashCode;
}

extension $UserLoginResponseExtension on UserLoginResponse {
  UserLoginResponse copyWith({String? jwt, String? refreshToken}) {
    return UserLoginResponse(
      jwt: jwt ?? this.jwt,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  UserLoginResponse copyWithWrapped({
    Wrapped<String>? jwt,
    Wrapped<String>? refreshToken,
  }) {
    return UserLoginResponse(
      jwt: (jwt != null ? jwt.value : this.jwt),
      refreshToken: (refreshToken != null
          ? refreshToken.value
          : this.refreshToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenLoginRequest {
  const TokenLoginRequest({required this.token});

  factory TokenLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenLoginRequestFromJson(json);

  static const toJsonFactory = _$TokenLoginRequestToJson;
  Map<String, dynamic> toJson() => _$TokenLoginRequestToJson(this);

  @JsonKey(name: 'token', includeIfNull: true)
  final String token;
  static const fromJsonFactory = _$TokenLoginRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenLoginRequest &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^ runtimeType.hashCode;
}

extension $TokenLoginRequestExtension on TokenLoginRequest {
  TokenLoginRequest copyWith({String? token}) {
    return TokenLoginRequest(token: token ?? this.token);
  }

  TokenLoginRequest copyWithWrapped({Wrapped<String>? token}) {
    return TokenLoginRequest(token: (token != null ? token.value : this.token));
  }
}

@JsonSerializable(explicitToJson: true)
class UnusedClipsResponse {
  const UnusedClipsResponse({
    this.productId,
    this.productName,
    this.ticketsLeft,
    this.unusedPurchasesValue,
  });

  factory UnusedClipsResponse.fromJson(Map<String, dynamic> json) =>
      _$UnusedClipsResponseFromJson(json);

  static const toJsonFactory = _$UnusedClipsResponseToJson;
  Map<String, dynamic> toJson() => _$UnusedClipsResponseToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int? productId;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String? productName;
  @JsonKey(name: 'ticketsLeft', includeIfNull: true)
  final int? ticketsLeft;
  @JsonKey(name: 'unusedPurchasesValue', includeIfNull: true)
  final double? unusedPurchasesValue;
  static const fromJsonFactory = _$UnusedClipsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UnusedClipsResponse &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.ticketsLeft, ticketsLeft) ||
                const DeepCollectionEquality().equals(
                  other.ticketsLeft,
                  ticketsLeft,
                )) &&
            (identical(other.unusedPurchasesValue, unusedPurchasesValue) ||
                const DeepCollectionEquality().equals(
                  other.unusedPurchasesValue,
                  unusedPurchasesValue,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(ticketsLeft) ^
      const DeepCollectionEquality().hash(unusedPurchasesValue) ^
      runtimeType.hashCode;
}

extension $UnusedClipsResponseExtension on UnusedClipsResponse {
  UnusedClipsResponse copyWith({
    int? productId,
    String? productName,
    int? ticketsLeft,
    double? unusedPurchasesValue,
  }) {
    return UnusedClipsResponse(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      ticketsLeft: ticketsLeft ?? this.ticketsLeft,
      unusedPurchasesValue: unusedPurchasesValue ?? this.unusedPurchasesValue,
    );
  }

  UnusedClipsResponse copyWithWrapped({
    Wrapped<int?>? productId,
    Wrapped<String?>? productName,
    Wrapped<int?>? ticketsLeft,
    Wrapped<double?>? unusedPurchasesValue,
  }) {
    return UnusedClipsResponse(
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      ticketsLeft: (ticketsLeft != null ? ticketsLeft.value : this.ticketsLeft),
      unusedPurchasesValue: (unusedPurchasesValue != null
          ? unusedPurchasesValue.value
          : this.unusedPurchasesValue),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UnusedClipsRequest {
  const UnusedClipsRequest({this.startDate, this.endDate});

  factory UnusedClipsRequest.fromJson(Map<String, dynamic> json) =>
      _$UnusedClipsRequestFromJson(json);

  static const toJsonFactory = _$UnusedClipsRequestToJson;
  Map<String, dynamic> toJson() => _$UnusedClipsRequestToJson(this);

  @JsonKey(name: 'startDate', includeIfNull: true)
  final DateTime? startDate;
  @JsonKey(name: 'endDate', includeIfNull: true)
  final DateTime? endDate;
  static const fromJsonFactory = _$UnusedClipsRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UnusedClipsRequest &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(other.endDate, endDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      runtimeType.hashCode;
}

extension $UnusedClipsRequestExtension on UnusedClipsRequest {
  UnusedClipsRequest copyWith({DateTime? startDate, DateTime? endDate}) {
    return UnusedClipsRequest(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  UnusedClipsRequest copyWithWrapped({
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
  }) {
    return UnusedClipsRequest(
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppConfig {
  const AppConfig({required this.environmentType});

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  static const toJsonFactory = _$AppConfigToJson;
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  @JsonKey(name: 'environmentType', includeIfNull: true)
  final dynamic environmentType;
  static const fromJsonFactory = _$AppConfigFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppConfig &&
            (identical(other.environmentType, environmentType) ||
                const DeepCollectionEquality().equals(
                  other.environmentType,
                  environmentType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(environmentType) ^
      runtimeType.hashCode;
}

extension $AppConfigExtension on AppConfig {
  AppConfig copyWith({dynamic environmentType}) {
    return AppConfig(environmentType: environmentType ?? this.environmentType);
  }

  AppConfig copyWithWrapped({Wrapped<dynamic>? environmentType}) {
    return AppConfig(
      environmentType: (environmentType != null
          ? environmentType.value
          : this.environmentType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ServiceHealthResponse {
  const ServiceHealthResponse({this.mobilePay, this.database});

  factory ServiceHealthResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceHealthResponseFromJson(json);

  static const toJsonFactory = _$ServiceHealthResponseToJson;
  Map<String, dynamic> toJson() => _$ServiceHealthResponseToJson(this);

  @JsonKey(name: 'mobilePay', includeIfNull: true)
  final bool? mobilePay;
  @JsonKey(name: 'database', includeIfNull: true)
  final bool? database;
  static const fromJsonFactory = _$ServiceHealthResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ServiceHealthResponse &&
            (identical(other.mobilePay, mobilePay) ||
                const DeepCollectionEquality().equals(
                  other.mobilePay,
                  mobilePay,
                )) &&
            (identical(other.database, database) ||
                const DeepCollectionEquality().equals(
                  other.database,
                  database,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(mobilePay) ^
      const DeepCollectionEquality().hash(database) ^
      runtimeType.hashCode;
}

extension $ServiceHealthResponseExtension on ServiceHealthResponse {
  ServiceHealthResponse copyWith({bool? mobilePay, bool? database}) {
    return ServiceHealthResponse(
      mobilePay: mobilePay ?? this.mobilePay,
      database: database ?? this.database,
    );
  }

  ServiceHealthResponse copyWithWrapped({
    Wrapped<bool?>? mobilePay,
    Wrapped<bool?>? database,
  }) {
    return ServiceHealthResponse(
      mobilePay: (mobilePay != null ? mobilePay.value : this.mobilePay),
      database: (database != null ? database.value : this.database),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LeaderboardEntry {
  const LeaderboardEntry({this.id, this.name, this.rank, this.score});

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);

  static const toJsonFactory = _$LeaderboardEntryToJson;
  Map<String, dynamic> toJson() => _$LeaderboardEntryToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: true)
  final String? name;
  @JsonKey(name: 'rank', includeIfNull: true)
  final int? rank;
  @JsonKey(name: 'score', includeIfNull: true)
  final int? score;
  static const fromJsonFactory = _$LeaderboardEntryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LeaderboardEntry &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.rank, rank) ||
                const DeepCollectionEquality().equals(other.rank, rank)) &&
            (identical(other.score, score) ||
                const DeepCollectionEquality().equals(other.score, score)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(rank) ^
      const DeepCollectionEquality().hash(score) ^
      runtimeType.hashCode;
}

extension $LeaderboardEntryExtension on LeaderboardEntry {
  LeaderboardEntry copyWith({int? id, String? name, int? rank, int? score}) {
    return LeaderboardEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      rank: rank ?? this.rank,
      score: score ?? this.score,
    );
  }

  LeaderboardEntry copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? name,
    Wrapped<int?>? rank,
    Wrapped<int?>? score,
  }) {
    return LeaderboardEntry(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      rank: (rank != null ? rank.value : this.rank),
      score: (score != null ? score.value : this.score),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MenuItemResponse {
  const MenuItemResponse({
    required this.id,
    required this.name,
    required this.active,
  });

  factory MenuItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuItemResponseFromJson(json);

  static const toJsonFactory = _$MenuItemResponseToJson;
  Map<String, dynamic> toJson() => _$MenuItemResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'active', includeIfNull: true)
  final bool active;
  static const fromJsonFactory = _$MenuItemResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MenuItemResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(active) ^
      runtimeType.hashCode;
}

extension $MenuItemResponseExtension on MenuItemResponse {
  MenuItemResponse copyWith({int? id, String? name, bool? active}) {
    return MenuItemResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  MenuItemResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? name,
    Wrapped<bool>? active,
  }) {
    return MenuItemResponse(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AddMenuItemRequest {
  const AddMenuItemRequest({required this.name});

  factory AddMenuItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMenuItemRequestFromJson(json);

  static const toJsonFactory = _$AddMenuItemRequestToJson;
  Map<String, dynamic> toJson() => _$AddMenuItemRequestToJson(this);

  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  static const fromJsonFactory = _$AddMenuItemRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddMenuItemRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $AddMenuItemRequestExtension on AddMenuItemRequest {
  AddMenuItemRequest copyWith({String? name}) {
    return AddMenuItemRequest(name: name ?? this.name);
  }

  AddMenuItemRequest copyWithWrapped({Wrapped<String>? name}) {
    return AddMenuItemRequest(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateMenuItemRequest {
  const UpdateMenuItemRequest({required this.name, required this.active});

  factory UpdateMenuItemRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMenuItemRequestFromJson(json);

  static const toJsonFactory = _$UpdateMenuItemRequestToJson;
  Map<String, dynamic> toJson() => _$UpdateMenuItemRequestToJson(this);

  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'active', includeIfNull: true)
  final bool active;
  static const fromJsonFactory = _$UpdateMenuItemRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateMenuItemRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(active) ^
      runtimeType.hashCode;
}

extension $UpdateMenuItemRequestExtension on UpdateMenuItemRequest {
  UpdateMenuItemRequest copyWith({String? name, bool? active}) {
    return UpdateMenuItemRequest(
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  UpdateMenuItemRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<bool>? active,
  }) {
    return UpdateMenuItemRequest(
      name: (name != null ? name.value : this.name),
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductResponse {
  const ProductResponse({
    required this.id,
    required this.price,
    required this.numberOfTickets,
    required this.name,
    required this.description,
    required this.isPerk,
    required this.visible,
    required this.allowedUserGroups,
    this.eligibleMenuItems,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  static const toJsonFactory = _$ProductResponseToJson;
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

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
  @JsonKey(name: 'isPerk', includeIfNull: true)
  final bool isPerk;
  @JsonKey(name: 'visible', includeIfNull: true)
  final bool visible;
  @JsonKey(
    name: 'allowedUserGroups',
    includeIfNull: true,
    toJson: userGroupListToJson,
    fromJson: userGroupListFromJson,
  )
  final List<enums.UserGroup> allowedUserGroups;
  @JsonKey(
    name: 'eligibleMenuItems',
    includeIfNull: true,
    defaultValue: <MenuItemResponse>[],
  )
  final List<MenuItemResponse>? eligibleMenuItems;
  static const fromJsonFactory = _$ProductResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductResponse &&
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
                )) &&
            (identical(other.isPerk, isPerk) ||
                const DeepCollectionEquality().equals(other.isPerk, isPerk)) &&
            (identical(other.visible, visible) ||
                const DeepCollectionEquality().equals(
                  other.visible,
                  visible,
                )) &&
            (identical(other.allowedUserGroups, allowedUserGroups) ||
                const DeepCollectionEquality().equals(
                  other.allowedUserGroups,
                  allowedUserGroups,
                )) &&
            (identical(other.eligibleMenuItems, eligibleMenuItems) ||
                const DeepCollectionEquality().equals(
                  other.eligibleMenuItems,
                  eligibleMenuItems,
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
      const DeepCollectionEquality().hash(isPerk) ^
      const DeepCollectionEquality().hash(visible) ^
      const DeepCollectionEquality().hash(allowedUserGroups) ^
      const DeepCollectionEquality().hash(eligibleMenuItems) ^
      runtimeType.hashCode;
}

extension $ProductResponseExtension on ProductResponse {
  ProductResponse copyWith({
    int? id,
    int? price,
    int? numberOfTickets,
    String? name,
    String? description,
    bool? isPerk,
    bool? visible,
    List<enums.UserGroup>? allowedUserGroups,
    List<MenuItemResponse>? eligibleMenuItems,
  }) {
    return ProductResponse(
      id: id ?? this.id,
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      name: name ?? this.name,
      description: description ?? this.description,
      isPerk: isPerk ?? this.isPerk,
      visible: visible ?? this.visible,
      allowedUserGroups: allowedUserGroups ?? this.allowedUserGroups,
      eligibleMenuItems: eligibleMenuItems ?? this.eligibleMenuItems,
    );
  }

  ProductResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<int>? price,
    Wrapped<int>? numberOfTickets,
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<bool>? isPerk,
    Wrapped<bool>? visible,
    Wrapped<List<enums.UserGroup>>? allowedUserGroups,
    Wrapped<List<MenuItemResponse>?>? eligibleMenuItems,
  }) {
    return ProductResponse(
      id: (id != null ? id.value : this.id),
      price: (price != null ? price.value : this.price),
      numberOfTickets: (numberOfTickets != null
          ? numberOfTickets.value
          : this.numberOfTickets),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      isPerk: (isPerk != null ? isPerk.value : this.isPerk),
      visible: (visible != null ? visible.value : this.visible),
      allowedUserGroups: (allowedUserGroups != null
          ? allowedUserGroups.value
          : this.allowedUserGroups),
      eligibleMenuItems: (eligibleMenuItems != null
          ? eligibleMenuItems.value
          : this.eligibleMenuItems),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AddProductRequest {
  const AddProductRequest({
    required this.price,
    required this.numberOfTickets,
    required this.name,
    required this.description,
    required this.visible,
    required this.allowedUserGroups,
    required this.menuItemIds,
  });

  factory AddProductRequest.fromJson(Map<String, dynamic> json) =>
      _$AddProductRequestFromJson(json);

  static const toJsonFactory = _$AddProductRequestToJson;
  Map<String, dynamic> toJson() => _$AddProductRequestToJson(this);

  @JsonKey(name: 'price', includeIfNull: true)
  final int price;
  @JsonKey(name: 'numberOfTickets', includeIfNull: true)
  final int numberOfTickets;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'description', includeIfNull: true)
  final String description;
  @JsonKey(name: 'visible', includeIfNull: true, defaultValue: true)
  final bool visible;
  @JsonKey(
    name: 'allowedUserGroups',
    includeIfNull: true,
    toJson: userGroupListToJson,
    fromJson: userGroupListFromJson,
  )
  final List<enums.UserGroup> allowedUserGroups;
  @JsonKey(name: 'menuItemIds', includeIfNull: true, defaultValue: <int>[])
  final List<int> menuItemIds;
  static const fromJsonFactory = _$AddProductRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddProductRequest &&
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
                )) &&
            (identical(other.visible, visible) ||
                const DeepCollectionEquality().equals(
                  other.visible,
                  visible,
                )) &&
            (identical(other.allowedUserGroups, allowedUserGroups) ||
                const DeepCollectionEquality().equals(
                  other.allowedUserGroups,
                  allowedUserGroups,
                )) &&
            (identical(other.menuItemIds, menuItemIds) ||
                const DeepCollectionEquality().equals(
                  other.menuItemIds,
                  menuItemIds,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(numberOfTickets) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(visible) ^
      const DeepCollectionEquality().hash(allowedUserGroups) ^
      const DeepCollectionEquality().hash(menuItemIds) ^
      runtimeType.hashCode;
}

extension $AddProductRequestExtension on AddProductRequest {
  AddProductRequest copyWith({
    int? price,
    int? numberOfTickets,
    String? name,
    String? description,
    bool? visible,
    List<enums.UserGroup>? allowedUserGroups,
    List<int>? menuItemIds,
  }) {
    return AddProductRequest(
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      name: name ?? this.name,
      description: description ?? this.description,
      visible: visible ?? this.visible,
      allowedUserGroups: allowedUserGroups ?? this.allowedUserGroups,
      menuItemIds: menuItemIds ?? this.menuItemIds,
    );
  }

  AddProductRequest copyWithWrapped({
    Wrapped<int>? price,
    Wrapped<int>? numberOfTickets,
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<bool>? visible,
    Wrapped<List<enums.UserGroup>>? allowedUserGroups,
    Wrapped<List<int>>? menuItemIds,
  }) {
    return AddProductRequest(
      price: (price != null ? price.value : this.price),
      numberOfTickets: (numberOfTickets != null
          ? numberOfTickets.value
          : this.numberOfTickets),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      visible: (visible != null ? visible.value : this.visible),
      allowedUserGroups: (allowedUserGroups != null
          ? allowedUserGroups.value
          : this.allowedUserGroups),
      menuItemIds: (menuItemIds != null ? menuItemIds.value : this.menuItemIds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateProductRequest {
  const UpdateProductRequest({
    required this.price,
    required this.numberOfTickets,
    required this.name,
    required this.description,
    required this.visible,
    required this.allowedUserGroups,
    required this.menuItemIds,
  });

  factory UpdateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductRequestFromJson(json);

  static const toJsonFactory = _$UpdateProductRequestToJson;
  Map<String, dynamic> toJson() => _$UpdateProductRequestToJson(this);

  @JsonKey(name: 'price', includeIfNull: true)
  final int price;
  @JsonKey(name: 'numberOfTickets', includeIfNull: true)
  final int numberOfTickets;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'description', includeIfNull: true)
  final String description;
  @JsonKey(name: 'visible', includeIfNull: true, defaultValue: true)
  final bool visible;
  @JsonKey(
    name: 'allowedUserGroups',
    includeIfNull: true,
    toJson: userGroupListToJson,
    fromJson: userGroupListFromJson,
  )
  final List<enums.UserGroup> allowedUserGroups;
  @JsonKey(name: 'menuItemIds', includeIfNull: true, defaultValue: <int>[])
  final List<int> menuItemIds;
  static const fromJsonFactory = _$UpdateProductRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateProductRequest &&
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
                )) &&
            (identical(other.visible, visible) ||
                const DeepCollectionEquality().equals(
                  other.visible,
                  visible,
                )) &&
            (identical(other.allowedUserGroups, allowedUserGroups) ||
                const DeepCollectionEquality().equals(
                  other.allowedUserGroups,
                  allowedUserGroups,
                )) &&
            (identical(other.menuItemIds, menuItemIds) ||
                const DeepCollectionEquality().equals(
                  other.menuItemIds,
                  menuItemIds,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(numberOfTickets) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(visible) ^
      const DeepCollectionEquality().hash(allowedUserGroups) ^
      const DeepCollectionEquality().hash(menuItemIds) ^
      runtimeType.hashCode;
}

extension $UpdateProductRequestExtension on UpdateProductRequest {
  UpdateProductRequest copyWith({
    int? price,
    int? numberOfTickets,
    String? name,
    String? description,
    bool? visible,
    List<enums.UserGroup>? allowedUserGroups,
    List<int>? menuItemIds,
  }) {
    return UpdateProductRequest(
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      name: name ?? this.name,
      description: description ?? this.description,
      visible: visible ?? this.visible,
      allowedUserGroups: allowedUserGroups ?? this.allowedUserGroups,
      menuItemIds: menuItemIds ?? this.menuItemIds,
    );
  }

  UpdateProductRequest copyWithWrapped({
    Wrapped<int>? price,
    Wrapped<int>? numberOfTickets,
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<bool>? visible,
    Wrapped<List<enums.UserGroup>>? allowedUserGroups,
    Wrapped<List<int>>? menuItemIds,
  }) {
    return UpdateProductRequest(
      price: (price != null ? price.value : this.price),
      numberOfTickets: (numberOfTickets != null
          ? numberOfTickets.value
          : this.numberOfTickets),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      visible: (visible != null ? visible.value : this.visible),
      allowedUserGroups: (allowedUserGroups != null
          ? allowedUserGroups.value
          : this.allowedUserGroups),
      menuItemIds: (menuItemIds != null ? menuItemIds.value : this.menuItemIds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SimplePurchaseResponse {
  const SimplePurchaseResponse({
    required this.id,
    required this.dateCreated,
    required this.productId,
    required this.productName,
    required this.numberOfTickets,
    required this.totalAmount,
    required this.purchaseStatus,
  });

  factory SimplePurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$SimplePurchaseResponseFromJson(json);

  static const toJsonFactory = _$SimplePurchaseResponseToJson;
  Map<String, dynamic> toJson() => _$SimplePurchaseResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  @JsonKey(name: 'numberOfTickets', includeIfNull: true)
  final int numberOfTickets;
  @JsonKey(name: 'totalAmount', includeIfNull: true)
  final int totalAmount;
  @JsonKey(name: 'purchaseStatus', includeIfNull: true)
  final dynamic purchaseStatus;
  static const fromJsonFactory = _$SimplePurchaseResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SimplePurchaseResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality().equals(
                  other.dateCreated,
                  dateCreated,
                )) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.numberOfTickets, numberOfTickets) ||
                const DeepCollectionEquality().equals(
                  other.numberOfTickets,
                  numberOfTickets,
                )) &&
            (identical(other.totalAmount, totalAmount) ||
                const DeepCollectionEquality().equals(
                  other.totalAmount,
                  totalAmount,
                )) &&
            (identical(other.purchaseStatus, purchaseStatus) ||
                const DeepCollectionEquality().equals(
                  other.purchaseStatus,
                  purchaseStatus,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(numberOfTickets) ^
      const DeepCollectionEquality().hash(totalAmount) ^
      const DeepCollectionEquality().hash(purchaseStatus) ^
      runtimeType.hashCode;
}

extension $SimplePurchaseResponseExtension on SimplePurchaseResponse {
  SimplePurchaseResponse copyWith({
    int? id,
    DateTime? dateCreated,
    int? productId,
    String? productName,
    int? numberOfTickets,
    int? totalAmount,
    dynamic purchaseStatus,
  }) {
    return SimplePurchaseResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      totalAmount: totalAmount ?? this.totalAmount,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
    );
  }

  SimplePurchaseResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<DateTime>? dateCreated,
    Wrapped<int>? productId,
    Wrapped<String>? productName,
    Wrapped<int>? numberOfTickets,
    Wrapped<int>? totalAmount,
    Wrapped<dynamic>? purchaseStatus,
  }) {
    return SimplePurchaseResponse(
      id: (id != null ? id.value : this.id),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      numberOfTickets: (numberOfTickets != null
          ? numberOfTickets.value
          : this.numberOfTickets),
      totalAmount: (totalAmount != null ? totalAmount.value : this.totalAmount),
      purchaseStatus: (purchaseStatus != null
          ? purchaseStatus.value
          : this.purchaseStatus),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SinglePurchaseResponse {
  const SinglePurchaseResponse({
    required this.id,
    required this.dateCreated,
    required this.productId,
    required this.totalAmount,
    required this.purchaseStatus,
    required this.paymentDetails,
  });

  factory SinglePurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$SinglePurchaseResponseFromJson(json);

  static const toJsonFactory = _$SinglePurchaseResponseToJson;
  Map<String, dynamic> toJson() => _$SinglePurchaseResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'totalAmount', includeIfNull: true)
  final int totalAmount;
  @JsonKey(name: 'purchaseStatus', includeIfNull: true)
  final dynamic purchaseStatus;
  @JsonKey(name: 'paymentDetails', includeIfNull: true)
  final dynamic paymentDetails;
  static const fromJsonFactory = _$SinglePurchaseResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SinglePurchaseResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality().equals(
                  other.dateCreated,
                  dateCreated,
                )) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.totalAmount, totalAmount) ||
                const DeepCollectionEquality().equals(
                  other.totalAmount,
                  totalAmount,
                )) &&
            (identical(other.purchaseStatus, purchaseStatus) ||
                const DeepCollectionEquality().equals(
                  other.purchaseStatus,
                  purchaseStatus,
                )) &&
            (identical(other.paymentDetails, paymentDetails) ||
                const DeepCollectionEquality().equals(
                  other.paymentDetails,
                  paymentDetails,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(totalAmount) ^
      const DeepCollectionEquality().hash(purchaseStatus) ^
      const DeepCollectionEquality().hash(paymentDetails) ^
      runtimeType.hashCode;
}

extension $SinglePurchaseResponseExtension on SinglePurchaseResponse {
  SinglePurchaseResponse copyWith({
    int? id,
    DateTime? dateCreated,
    int? productId,
    int? totalAmount,
    dynamic purchaseStatus,
    dynamic paymentDetails,
  }) {
    return SinglePurchaseResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      productId: productId ?? this.productId,
      totalAmount: totalAmount ?? this.totalAmount,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
      paymentDetails: paymentDetails ?? this.paymentDetails,
    );
  }

  SinglePurchaseResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<DateTime>? dateCreated,
    Wrapped<int>? productId,
    Wrapped<int>? totalAmount,
    Wrapped<dynamic>? purchaseStatus,
    Wrapped<dynamic>? paymentDetails,
  }) {
    return SinglePurchaseResponse(
      id: (id != null ? id.value : this.id),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      productId: (productId != null ? productId.value : this.productId),
      totalAmount: (totalAmount != null ? totalAmount.value : this.totalAmount),
      purchaseStatus: (purchaseStatus != null
          ? purchaseStatus.value
          : this.purchaseStatus),
      paymentDetails: (paymentDetails != null
          ? paymentDetails.value
          : this.paymentDetails),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentDetails {
  const PaymentDetails({
    required this.paymentType,
    required this.orderId,
    required this.discriminator,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailsFromJson(json);

  static const toJsonFactory = _$PaymentDetailsToJson;
  Map<String, dynamic> toJson() => _$PaymentDetailsToJson(this);

  @JsonKey(name: 'paymentType', includeIfNull: true)
  final dynamic paymentType;
  @JsonKey(name: 'orderId', includeIfNull: true)
  final String orderId;
  @JsonKey(name: 'discriminator', includeIfNull: true)
  final String discriminator;
  static const fromJsonFactory = _$PaymentDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentDetails &&
            (identical(other.paymentType, paymentType) ||
                const DeepCollectionEquality().equals(
                  other.paymentType,
                  paymentType,
                )) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.discriminator, discriminator) ||
                const DeepCollectionEquality().equals(
                  other.discriminator,
                  discriminator,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(paymentType) ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(discriminator) ^
      runtimeType.hashCode;
}

extension $PaymentDetailsExtension on PaymentDetails {
  PaymentDetails copyWith({
    dynamic paymentType,
    String? orderId,
    String? discriminator,
  }) {
    return PaymentDetails(
      paymentType: paymentType ?? this.paymentType,
      orderId: orderId ?? this.orderId,
      discriminator: discriminator ?? this.discriminator,
    );
  }

  PaymentDetails copyWithWrapped({
    Wrapped<dynamic>? paymentType,
    Wrapped<String>? orderId,
    Wrapped<String>? discriminator,
  }) {
    return PaymentDetails(
      paymentType: (paymentType != null ? paymentType.value : this.paymentType),
      orderId: (orderId != null ? orderId.value : this.orderId),
      discriminator: (discriminator != null
          ? discriminator.value
          : this.discriminator),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MobilePayPaymentDetails {
  const MobilePayPaymentDetails({
    required this.mobilePayAppRedirectUri,
    required this.paymentId,
    required this.paymentType,
    required this.orderId,
    required this.discriminator,
  });

  factory MobilePayPaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$MobilePayPaymentDetailsFromJson(json);

  static const toJsonFactory = _$MobilePayPaymentDetailsToJson;
  Map<String, dynamic> toJson() => _$MobilePayPaymentDetailsToJson(this);

  @JsonKey(name: 'mobilePayAppRedirectUri', includeIfNull: true)
  final String mobilePayAppRedirectUri;
  @JsonKey(name: 'paymentId', includeIfNull: true)
  final String paymentId;
  @JsonKey(name: 'paymentType', includeIfNull: true)
  final dynamic paymentType;
  @JsonKey(name: 'orderId', includeIfNull: true)
  final String orderId;
  @JsonKey(name: 'discriminator', includeIfNull: true)
  final String discriminator;
  static const fromJsonFactory = _$MobilePayPaymentDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MobilePayPaymentDetails &&
            (identical(
                  other.mobilePayAppRedirectUri,
                  mobilePayAppRedirectUri,
                ) ||
                const DeepCollectionEquality().equals(
                  other.mobilePayAppRedirectUri,
                  mobilePayAppRedirectUri,
                )) &&
            (identical(other.paymentId, paymentId) ||
                const DeepCollectionEquality().equals(
                  other.paymentId,
                  paymentId,
                )) &&
            (identical(other.paymentType, paymentType) ||
                const DeepCollectionEquality().equals(
                  other.paymentType,
                  paymentType,
                )) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.discriminator, discriminator) ||
                const DeepCollectionEquality().equals(
                  other.discriminator,
                  discriminator,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(mobilePayAppRedirectUri) ^
      const DeepCollectionEquality().hash(paymentId) ^
      const DeepCollectionEquality().hash(paymentType) ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(discriminator) ^
      runtimeType.hashCode;
}

extension $MobilePayPaymentDetailsExtension on MobilePayPaymentDetails {
  MobilePayPaymentDetails copyWith({
    String? mobilePayAppRedirectUri,
    String? paymentId,
    dynamic paymentType,
    String? orderId,
    String? discriminator,
  }) {
    return MobilePayPaymentDetails(
      mobilePayAppRedirectUri:
          mobilePayAppRedirectUri ?? this.mobilePayAppRedirectUri,
      paymentId: paymentId ?? this.paymentId,
      paymentType: paymentType ?? this.paymentType,
      orderId: orderId ?? this.orderId,
      discriminator: discriminator ?? this.discriminator,
    );
  }

  MobilePayPaymentDetails copyWithWrapped({
    Wrapped<String>? mobilePayAppRedirectUri,
    Wrapped<String>? paymentId,
    Wrapped<dynamic>? paymentType,
    Wrapped<String>? orderId,
    Wrapped<String>? discriminator,
  }) {
    return MobilePayPaymentDetails(
      mobilePayAppRedirectUri: (mobilePayAppRedirectUri != null
          ? mobilePayAppRedirectUri.value
          : this.mobilePayAppRedirectUri),
      paymentId: (paymentId != null ? paymentId.value : this.paymentId),
      paymentType: (paymentType != null ? paymentType.value : this.paymentType),
      orderId: (orderId != null ? orderId.value : this.orderId),
      discriminator: (discriminator != null
          ? discriminator.value
          : this.discriminator),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class FreePurchasePaymentDetails {
  const FreePurchasePaymentDetails({
    required this.paymentType,
    required this.orderId,
    required this.discriminator,
  });

  factory FreePurchasePaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$FreePurchasePaymentDetailsFromJson(json);

  static const toJsonFactory = _$FreePurchasePaymentDetailsToJson;
  Map<String, dynamic> toJson() => _$FreePurchasePaymentDetailsToJson(this);

  @JsonKey(name: 'paymentType', includeIfNull: true)
  final dynamic paymentType;
  @JsonKey(name: 'orderId', includeIfNull: true)
  final String orderId;
  @JsonKey(name: 'discriminator', includeIfNull: true)
  final String discriminator;
  static const fromJsonFactory = _$FreePurchasePaymentDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FreePurchasePaymentDetails &&
            (identical(other.paymentType, paymentType) ||
                const DeepCollectionEquality().equals(
                  other.paymentType,
                  paymentType,
                )) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.discriminator, discriminator) ||
                const DeepCollectionEquality().equals(
                  other.discriminator,
                  discriminator,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(paymentType) ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(discriminator) ^
      runtimeType.hashCode;
}

extension $FreePurchasePaymentDetailsExtension on FreePurchasePaymentDetails {
  FreePurchasePaymentDetails copyWith({
    dynamic paymentType,
    String? orderId,
    String? discriminator,
  }) {
    return FreePurchasePaymentDetails(
      paymentType: paymentType ?? this.paymentType,
      orderId: orderId ?? this.orderId,
      discriminator: discriminator ?? this.discriminator,
    );
  }

  FreePurchasePaymentDetails copyWithWrapped({
    Wrapped<dynamic>? paymentType,
    Wrapped<String>? orderId,
    Wrapped<String>? discriminator,
  }) {
    return FreePurchasePaymentDetails(
      paymentType: (paymentType != null ? paymentType.value : this.paymentType),
      orderId: (orderId != null ? orderId.value : this.orderId),
      discriminator: (discriminator != null
          ? discriminator.value
          : this.discriminator),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class InitiatePurchaseResponse {
  const InitiatePurchaseResponse({
    required this.id,
    required this.dateCreated,
    required this.productId,
    required this.productName,
    required this.totalAmount,
    required this.purchaseStatus,
    required this.paymentDetails,
  });

  factory InitiatePurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiatePurchaseResponseFromJson(json);

  static const toJsonFactory = _$InitiatePurchaseResponseToJson;
  Map<String, dynamic> toJson() => _$InitiatePurchaseResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  @JsonKey(name: 'totalAmount', includeIfNull: true)
  final int totalAmount;
  @JsonKey(name: 'purchaseStatus', includeIfNull: true)
  final dynamic purchaseStatus;
  @JsonKey(name: 'paymentDetails', includeIfNull: true)
  final dynamic paymentDetails;
  static const fromJsonFactory = _$InitiatePurchaseResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InitiatePurchaseResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality().equals(
                  other.dateCreated,
                  dateCreated,
                )) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.totalAmount, totalAmount) ||
                const DeepCollectionEquality().equals(
                  other.totalAmount,
                  totalAmount,
                )) &&
            (identical(other.purchaseStatus, purchaseStatus) ||
                const DeepCollectionEquality().equals(
                  other.purchaseStatus,
                  purchaseStatus,
                )) &&
            (identical(other.paymentDetails, paymentDetails) ||
                const DeepCollectionEquality().equals(
                  other.paymentDetails,
                  paymentDetails,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(totalAmount) ^
      const DeepCollectionEquality().hash(purchaseStatus) ^
      const DeepCollectionEquality().hash(paymentDetails) ^
      runtimeType.hashCode;
}

extension $InitiatePurchaseResponseExtension on InitiatePurchaseResponse {
  InitiatePurchaseResponse copyWith({
    int? id,
    DateTime? dateCreated,
    int? productId,
    String? productName,
    int? totalAmount,
    dynamic purchaseStatus,
    dynamic paymentDetails,
  }) {
    return InitiatePurchaseResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      totalAmount: totalAmount ?? this.totalAmount,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
      paymentDetails: paymentDetails ?? this.paymentDetails,
    );
  }

  InitiatePurchaseResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<DateTime>? dateCreated,
    Wrapped<int>? productId,
    Wrapped<String>? productName,
    Wrapped<int>? totalAmount,
    Wrapped<dynamic>? purchaseStatus,
    Wrapped<dynamic>? paymentDetails,
  }) {
    return InitiatePurchaseResponse(
      id: (id != null ? id.value : this.id),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      totalAmount: (totalAmount != null ? totalAmount.value : this.totalAmount),
      purchaseStatus: (purchaseStatus != null
          ? purchaseStatus.value
          : this.purchaseStatus),
      paymentDetails: (paymentDetails != null
          ? paymentDetails.value
          : this.paymentDetails),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class InitiatePurchaseRequest {
  const InitiatePurchaseRequest({
    required this.productId,
    required this.paymentType,
  });

  factory InitiatePurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$InitiatePurchaseRequestFromJson(json);

  static const toJsonFactory = _$InitiatePurchaseRequestToJson;
  Map<String, dynamic> toJson() => _$InitiatePurchaseRequestToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'paymentType', includeIfNull: true)
  final dynamic paymentType;
  static const fromJsonFactory = _$InitiatePurchaseRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InitiatePurchaseRequest &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.paymentType, paymentType) ||
                const DeepCollectionEquality().equals(
                  other.paymentType,
                  paymentType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(paymentType) ^
      runtimeType.hashCode;
}

extension $InitiatePurchaseRequestExtension on InitiatePurchaseRequest {
  InitiatePurchaseRequest copyWith({int? productId, dynamic paymentType}) {
    return InitiatePurchaseRequest(
      productId: productId ?? this.productId,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  InitiatePurchaseRequest copyWithWrapped({
    Wrapped<int>? productId,
    Wrapped<dynamic>? paymentType,
  }) {
    return InitiatePurchaseRequest(
      productId: (productId != null ? productId.value : this.productId),
      paymentType: (paymentType != null ? paymentType.value : this.paymentType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TicketResponse {
  const TicketResponse({
    required this.id,
    required this.dateCreated,
    this.dateUsed,
    required this.productId,
    required this.productName,
    this.usedOnMenuItemName,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketResponseFromJson(json);

  static const toJsonFactory = _$TicketResponseToJson;
  Map<String, dynamic> toJson() => _$TicketResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final int id;
  @JsonKey(name: 'dateCreated', includeIfNull: true)
  final DateTime dateCreated;
  @JsonKey(name: 'dateUsed', includeIfNull: true)
  final DateTime? dateUsed;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  @JsonKey(name: 'usedOnMenuItemName', includeIfNull: true)
  final String? usedOnMenuItemName;
  static const fromJsonFactory = _$TicketResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TicketResponse &&
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
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.usedOnMenuItemName, usedOnMenuItemName) ||
                const DeepCollectionEquality().equals(
                  other.usedOnMenuItemName,
                  usedOnMenuItemName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(dateUsed) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(usedOnMenuItemName) ^
      runtimeType.hashCode;
}

extension $TicketResponseExtension on TicketResponse {
  TicketResponse copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateUsed,
    int? productId,
    String? productName,
    String? usedOnMenuItemName,
  }) {
    return TicketResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUsed: dateUsed ?? this.dateUsed,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      usedOnMenuItemName: usedOnMenuItemName ?? this.usedOnMenuItemName,
    );
  }

  TicketResponse copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<DateTime>? dateCreated,
    Wrapped<DateTime?>? dateUsed,
    Wrapped<int>? productId,
    Wrapped<String>? productName,
    Wrapped<String?>? usedOnMenuItemName,
  }) {
    return TicketResponse(
      id: (id != null ? id.value : this.id),
      dateCreated: (dateCreated != null ? dateCreated.value : this.dateCreated),
      dateUsed: (dateUsed != null ? dateUsed.value : this.dateUsed),
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      usedOnMenuItemName: (usedOnMenuItemName != null
          ? usedOnMenuItemName.value
          : this.usedOnMenuItemName),
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
class UseTicketRequest {
  const UseTicketRequest({required this.productId, required this.menuItemId});

  factory UseTicketRequest.fromJson(Map<String, dynamic> json) =>
      _$UseTicketRequestFromJson(json);

  static const toJsonFactory = _$UseTicketRequestToJson;
  Map<String, dynamic> toJson() => _$UseTicketRequestToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'menuItemId', includeIfNull: true)
  final int menuItemId;
  static const fromJsonFactory = _$UseTicketRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UseTicketRequest &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.menuItemId, menuItemId) ||
                const DeepCollectionEquality().equals(
                  other.menuItemId,
                  menuItemId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(menuItemId) ^
      runtimeType.hashCode;
}

extension $UseTicketRequestExtension on UseTicketRequest {
  UseTicketRequest copyWith({int? productId, int? menuItemId}) {
    return UseTicketRequest(
      productId: productId ?? this.productId,
      menuItemId: menuItemId ?? this.menuItemId,
    );
  }

  UseTicketRequest copyWithWrapped({
    Wrapped<int>? productId,
    Wrapped<int>? menuItemId,
  }) {
    return UseTicketRequest(
      productId: (productId != null ? productId.value : this.productId),
      menuItemId: (menuItemId != null ? menuItemId.value : this.menuItemId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueVoucherResponse {
  const IssueVoucherResponse({
    required this.voucherCode,
    required this.productId,
    required this.productName,
    required this.issuedAt,
  });

  factory IssueVoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$IssueVoucherResponseFromJson(json);

  static const toJsonFactory = _$IssueVoucherResponseToJson;
  Map<String, dynamic> toJson() => _$IssueVoucherResponseToJson(this);

  @JsonKey(name: 'voucherCode', includeIfNull: true)
  final String voucherCode;
  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'productName', includeIfNull: true)
  final String productName;
  @JsonKey(name: 'issuedAt', includeIfNull: true)
  final DateTime issuedAt;
  static const fromJsonFactory = _$IssueVoucherResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueVoucherResponse &&
            (identical(other.voucherCode, voucherCode) ||
                const DeepCollectionEquality().equals(
                  other.voucherCode,
                  voucherCode,
                )) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality().equals(
                  other.productName,
                  productName,
                )) &&
            (identical(other.issuedAt, issuedAt) ||
                const DeepCollectionEquality().equals(
                  other.issuedAt,
                  issuedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(voucherCode) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(issuedAt) ^
      runtimeType.hashCode;
}

extension $IssueVoucherResponseExtension on IssueVoucherResponse {
  IssueVoucherResponse copyWith({
    String? voucherCode,
    int? productId,
    String? productName,
    DateTime? issuedAt,
  }) {
    return IssueVoucherResponse(
      voucherCode: voucherCode ?? this.voucherCode,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      issuedAt: issuedAt ?? this.issuedAt,
    );
  }

  IssueVoucherResponse copyWithWrapped({
    Wrapped<String>? voucherCode,
    Wrapped<int>? productId,
    Wrapped<String>? productName,
    Wrapped<DateTime>? issuedAt,
  }) {
    return IssueVoucherResponse(
      voucherCode: (voucherCode != null ? voucherCode.value : this.voucherCode),
      productId: (productId != null ? productId.value : this.productId),
      productName: (productName != null ? productName.value : this.productName),
      issuedAt: (issuedAt != null ? issuedAt.value : this.issuedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueVoucherRequest {
  const IssueVoucherRequest({
    required this.productId,
    required this.amount,
    required this.voucherPrefix,
    required this.description,
    required this.requester,
  });

  factory IssueVoucherRequest.fromJson(Map<String, dynamic> json) =>
      _$IssueVoucherRequestFromJson(json);

  static const toJsonFactory = _$IssueVoucherRequestToJson;
  Map<String, dynamic> toJson() => _$IssueVoucherRequestToJson(this);

  @JsonKey(name: 'productId', includeIfNull: true)
  final int productId;
  @JsonKey(name: 'amount', includeIfNull: true)
  final int amount;
  @JsonKey(name: 'voucherPrefix', includeIfNull: true)
  final String voucherPrefix;
  @JsonKey(name: 'description', includeIfNull: true)
  final String description;
  @JsonKey(name: 'requester', includeIfNull: true)
  final String requester;
  static const fromJsonFactory = _$IssueVoucherRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueVoucherRequest &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.voucherPrefix, voucherPrefix) ||
                const DeepCollectionEquality().equals(
                  other.voucherPrefix,
                  voucherPrefix,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.requester, requester) ||
                const DeepCollectionEquality().equals(
                  other.requester,
                  requester,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(voucherPrefix) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(requester) ^
      runtimeType.hashCode;
}

extension $IssueVoucherRequestExtension on IssueVoucherRequest {
  IssueVoucherRequest copyWith({
    int? productId,
    int? amount,
    String? voucherPrefix,
    String? description,
    String? requester,
  }) {
    return IssueVoucherRequest(
      productId: productId ?? this.productId,
      amount: amount ?? this.amount,
      voucherPrefix: voucherPrefix ?? this.voucherPrefix,
      description: description ?? this.description,
      requester: requester ?? this.requester,
    );
  }

  IssueVoucherRequest copyWithWrapped({
    Wrapped<int>? productId,
    Wrapped<int>? amount,
    Wrapped<String>? voucherPrefix,
    Wrapped<String>? description,
    Wrapped<String>? requester,
  }) {
    return IssueVoucherRequest(
      productId: (productId != null ? productId.value : this.productId),
      amount: (amount != null ? amount.value : this.amount),
      voucherPrefix: (voucherPrefix != null
          ? voucherPrefix.value
          : this.voucherPrefix),
      description: (description != null ? description.value : this.description),
      requester: (requester != null ? requester.value : this.requester),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookUpdateUserGroupRequest {
  const WebhookUpdateUserGroupRequest({required this.privilegedUsers});

  factory WebhookUpdateUserGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$WebhookUpdateUserGroupRequestFromJson(json);

  static const toJsonFactory = _$WebhookUpdateUserGroupRequestToJson;
  Map<String, dynamic> toJson() => _$WebhookUpdateUserGroupRequestToJson(this);

  @JsonKey(
    name: 'privilegedUsers',
    includeIfNull: true,
    defaultValue: <AccountUserGroup>[],
  )
  final List<AccountUserGroup> privilegedUsers;
  static const fromJsonFactory = _$WebhookUpdateUserGroupRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhookUpdateUserGroupRequest &&
            (identical(other.privilegedUsers, privilegedUsers) ||
                const DeepCollectionEquality().equals(
                  other.privilegedUsers,
                  privilegedUsers,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(privilegedUsers) ^
      runtimeType.hashCode;
}

extension $WebhookUpdateUserGroupRequestExtension
    on WebhookUpdateUserGroupRequest {
  WebhookUpdateUserGroupRequest copyWith({
    List<AccountUserGroup>? privilegedUsers,
  }) {
    return WebhookUpdateUserGroupRequest(
      privilegedUsers: privilegedUsers ?? this.privilegedUsers,
    );
  }

  WebhookUpdateUserGroupRequest copyWithWrapped({
    Wrapped<List<AccountUserGroup>>? privilegedUsers,
  }) {
    return WebhookUpdateUserGroupRequest(
      privilegedUsers: (privilegedUsers != null
          ? privilegedUsers.value
          : this.privilegedUsers),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountUserGroup {
  const AccountUserGroup({required this.accountId, required this.userGroup});

  factory AccountUserGroup.fromJson(Map<String, dynamic> json) =>
      _$AccountUserGroupFromJson(json);

  static const toJsonFactory = _$AccountUserGroupToJson;
  Map<String, dynamic> toJson() => _$AccountUserGroupToJson(this);

  @JsonKey(name: 'accountId', includeIfNull: true)
  final int accountId;
  @JsonKey(name: 'userGroup', includeIfNull: true)
  final dynamic userGroup;
  static const fromJsonFactory = _$AccountUserGroupFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountUserGroup &&
            (identical(other.accountId, accountId) ||
                const DeepCollectionEquality().equals(
                  other.accountId,
                  accountId,
                )) &&
            (identical(other.userGroup, userGroup) ||
                const DeepCollectionEquality().equals(
                  other.userGroup,
                  userGroup,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accountId) ^
      const DeepCollectionEquality().hash(userGroup) ^
      runtimeType.hashCode;
}

extension $AccountUserGroupExtension on AccountUserGroup {
  AccountUserGroup copyWith({int? accountId, dynamic userGroup}) {
    return AccountUserGroup(
      accountId: accountId ?? this.accountId,
      userGroup: userGroup ?? this.userGroup,
    );
  }

  AccountUserGroup copyWithWrapped({
    Wrapped<int>? accountId,
    Wrapped<dynamic>? userGroup,
  }) {
    return AccountUserGroup(
      accountId: (accountId != null ? accountId.value : this.accountId),
      userGroup: (userGroup != null ? userGroup.value : this.userGroup),
    );
  }
}

String? userRoleNullableToJson(enums.UserRole? userRole) {
  return userRole?.value;
}

String? userRoleToJson(enums.UserRole userRole) {
  return userRole.value;
}

enums.UserRole userRoleFromJson(
  Object? userRole, [
  enums.UserRole? defaultValue,
]) {
  return enums.UserRole.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            userRole?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.UserRole.swaggerGeneratedUnknown;
}

enums.UserRole? userRoleNullableFromJson(
  Object? userRole, [
  enums.UserRole? defaultValue,
]) {
  if (userRole == null) {
    return null;
  }
  return enums.UserRole.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            userRole.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String userRoleExplodedListToJson(List<enums.UserRole>? userRole) {
  return userRole?.map((e) => e.value!).join(',') ?? '';
}

List<String> userRoleListToJson(List<enums.UserRole>? userRole) {
  if (userRole == null) {
    return [];
  }

  return userRole.map((e) => e.value!).toList();
}

List<enums.UserRole> userRoleListFromJson(
  List? userRole, [
  List<enums.UserRole>? defaultValue,
]) {
  if (userRole == null) {
    return defaultValue ?? [];
  }

  return userRole.map((e) => userRoleFromJson(e.toString())).toList();
}

List<enums.UserRole>? userRoleNullableListFromJson(
  List? userRole, [
  List<enums.UserRole>? defaultValue,
]) {
  if (userRole == null) {
    return defaultValue;
  }

  return userRole.map((e) => userRoleFromJson(e.toString())).toList();
}

String? userGroupNullableToJson(enums.UserGroup? userGroup) {
  return userGroup?.value;
}

String? userGroupToJson(enums.UserGroup userGroup) {
  return userGroup.value;
}

enums.UserGroup userGroupFromJson(
  Object? userGroup, [
  enums.UserGroup? defaultValue,
]) {
  return enums.UserGroup.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            userGroup?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.UserGroup.swaggerGeneratedUnknown;
}

enums.UserGroup? userGroupNullableFromJson(
  Object? userGroup, [
  enums.UserGroup? defaultValue,
]) {
  if (userGroup == null) {
    return null;
  }
  return enums.UserGroup.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            userGroup.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String userGroupExplodedListToJson(List<enums.UserGroup>? userGroup) {
  return userGroup?.map((e) => e.value!).join(',') ?? '';
}

List<String> userGroupListToJson(List<enums.UserGroup>? userGroup) {
  if (userGroup == null) {
    return [];
  }

  return userGroup.map((e) => e.value!).toList();
}

List<enums.UserGroup> userGroupListFromJson(
  List? userGroup, [
  List<enums.UserGroup>? defaultValue,
]) {
  if (userGroup == null) {
    return defaultValue ?? [];
  }

  return userGroup.map((e) => userGroupFromJson(e.toString())).toList();
}

List<enums.UserGroup>? userGroupNullableListFromJson(
  List? userGroup, [
  List<enums.UserGroup>? defaultValue,
]) {
  if (userGroup == null) {
    return defaultValue;
  }

  return userGroup.map((e) => userGroupFromJson(e.toString())).toList();
}

String? userStateNullableToJson(enums.UserState? userState) {
  return userState?.value;
}

String? userStateToJson(enums.UserState userState) {
  return userState.value;
}

enums.UserState userStateFromJson(
  Object? userState, [
  enums.UserState? defaultValue,
]) {
  return enums.UserState.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            userState?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.UserState.swaggerGeneratedUnknown;
}

enums.UserState? userStateNullableFromJson(
  Object? userState, [
  enums.UserState? defaultValue,
]) {
  if (userState == null) {
    return null;
  }
  return enums.UserState.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            userState.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String userStateExplodedListToJson(List<enums.UserState>? userState) {
  return userState?.map((e) => e.value!).join(',') ?? '';
}

List<String> userStateListToJson(List<enums.UserState>? userState) {
  if (userState == null) {
    return [];
  }

  return userState.map((e) => e.value!).toList();
}

List<enums.UserState> userStateListFromJson(
  List? userState, [
  List<enums.UserState>? defaultValue,
]) {
  if (userState == null) {
    return defaultValue ?? [];
  }

  return userState.map((e) => userStateFromJson(e.toString())).toList();
}

List<enums.UserState>? userStateNullableListFromJson(
  List? userState, [
  List<enums.UserState>? defaultValue,
]) {
  if (userState == null) {
    return defaultValue;
  }

  return userState.map((e) => userStateFromJson(e.toString())).toList();
}

String? loginTypeNullableToJson(enums.LoginType? loginType) {
  return loginType?.value;
}

String? loginTypeToJson(enums.LoginType loginType) {
  return loginType.value;
}

enums.LoginType loginTypeFromJson(
  Object? loginType, [
  enums.LoginType? defaultValue,
]) {
  return enums.LoginType.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            loginType?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.LoginType.swaggerGeneratedUnknown;
}

enums.LoginType? loginTypeNullableFromJson(
  Object? loginType, [
  enums.LoginType? defaultValue,
]) {
  if (loginType == null) {
    return null;
  }
  return enums.LoginType.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            loginType.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String loginTypeExplodedListToJson(List<enums.LoginType>? loginType) {
  return loginType?.map((e) => e.value!).join(',') ?? '';
}

List<String> loginTypeListToJson(List<enums.LoginType>? loginType) {
  if (loginType == null) {
    return [];
  }

  return loginType.map((e) => e.value!).toList();
}

List<enums.LoginType> loginTypeListFromJson(
  List? loginType, [
  List<enums.LoginType>? defaultValue,
]) {
  if (loginType == null) {
    return defaultValue ?? [];
  }

  return loginType.map((e) => loginTypeFromJson(e.toString())).toList();
}

List<enums.LoginType>? loginTypeNullableListFromJson(
  List? loginType, [
  List<enums.LoginType>? defaultValue,
]) {
  if (loginType == null) {
    return defaultValue;
  }

  return loginType.map((e) => loginTypeFromJson(e.toString())).toList();
}

String? environmentTypeNullableToJson(enums.EnvironmentType? environmentType) {
  return environmentType?.value;
}

String? environmentTypeToJson(enums.EnvironmentType environmentType) {
  return environmentType.value;
}

enums.EnvironmentType environmentTypeFromJson(
  Object? environmentType, [
  enums.EnvironmentType? defaultValue,
]) {
  return enums.EnvironmentType.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            environmentType?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.EnvironmentType.swaggerGeneratedUnknown;
}

enums.EnvironmentType? environmentTypeNullableFromJson(
  Object? environmentType, [
  enums.EnvironmentType? defaultValue,
]) {
  if (environmentType == null) {
    return null;
  }
  return enums.EnvironmentType.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            environmentType.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String environmentTypeExplodedListToJson(
  List<enums.EnvironmentType>? environmentType,
) {
  return environmentType?.map((e) => e.value!).join(',') ?? '';
}

List<String> environmentTypeListToJson(
  List<enums.EnvironmentType>? environmentType,
) {
  if (environmentType == null) {
    return [];
  }

  return environmentType.map((e) => e.value!).toList();
}

List<enums.EnvironmentType> environmentTypeListFromJson(
  List? environmentType, [
  List<enums.EnvironmentType>? defaultValue,
]) {
  if (environmentType == null) {
    return defaultValue ?? [];
  }

  return environmentType
      .map((e) => environmentTypeFromJson(e.toString()))
      .toList();
}

List<enums.EnvironmentType>? environmentTypeNullableListFromJson(
  List? environmentType, [
  List<enums.EnvironmentType>? defaultValue,
]) {
  if (environmentType == null) {
    return defaultValue;
  }

  return environmentType
      .map((e) => environmentTypeFromJson(e.toString()))
      .toList();
}

String? leaderboardPresetNullableToJson(
  enums.LeaderboardPreset? leaderboardPreset,
) {
  return leaderboardPreset?.value;
}

String? leaderboardPresetToJson(enums.LeaderboardPreset leaderboardPreset) {
  return leaderboardPreset.value;
}

enums.LeaderboardPreset leaderboardPresetFromJson(
  Object? leaderboardPreset, [
  enums.LeaderboardPreset? defaultValue,
]) {
  return enums.LeaderboardPreset.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            leaderboardPreset?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.LeaderboardPreset.swaggerGeneratedUnknown;
}

enums.LeaderboardPreset? leaderboardPresetNullableFromJson(
  Object? leaderboardPreset, [
  enums.LeaderboardPreset? defaultValue,
]) {
  if (leaderboardPreset == null) {
    return null;
  }
  return enums.LeaderboardPreset.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            leaderboardPreset.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String leaderboardPresetExplodedListToJson(
  List<enums.LeaderboardPreset>? leaderboardPreset,
) {
  return leaderboardPreset?.map((e) => e.value!).join(',') ?? '';
}

List<String> leaderboardPresetListToJson(
  List<enums.LeaderboardPreset>? leaderboardPreset,
) {
  if (leaderboardPreset == null) {
    return [];
  }

  return leaderboardPreset.map((e) => e.value!).toList();
}

List<enums.LeaderboardPreset> leaderboardPresetListFromJson(
  List? leaderboardPreset, [
  List<enums.LeaderboardPreset>? defaultValue,
]) {
  if (leaderboardPreset == null) {
    return defaultValue ?? [];
  }

  return leaderboardPreset
      .map((e) => leaderboardPresetFromJson(e.toString()))
      .toList();
}

List<enums.LeaderboardPreset>? leaderboardPresetNullableListFromJson(
  List? leaderboardPreset, [
  List<enums.LeaderboardPreset>? defaultValue,
]) {
  if (leaderboardPreset == null) {
    return defaultValue;
  }

  return leaderboardPreset
      .map((e) => leaderboardPresetFromJson(e.toString()))
      .toList();
}

String? purchaseStatusNullableToJson(enums.PurchaseStatus? purchaseStatus) {
  return purchaseStatus?.value;
}

String? purchaseStatusToJson(enums.PurchaseStatus purchaseStatus) {
  return purchaseStatus.value;
}

enums.PurchaseStatus purchaseStatusFromJson(
  Object? purchaseStatus, [
  enums.PurchaseStatus? defaultValue,
]) {
  return enums.PurchaseStatus.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            purchaseStatus?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.PurchaseStatus.swaggerGeneratedUnknown;
}

enums.PurchaseStatus? purchaseStatusNullableFromJson(
  Object? purchaseStatus, [
  enums.PurchaseStatus? defaultValue,
]) {
  if (purchaseStatus == null) {
    return null;
  }
  return enums.PurchaseStatus.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            purchaseStatus.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String purchaseStatusExplodedListToJson(
  List<enums.PurchaseStatus>? purchaseStatus,
) {
  return purchaseStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> purchaseStatusListToJson(
  List<enums.PurchaseStatus>? purchaseStatus,
) {
  if (purchaseStatus == null) {
    return [];
  }

  return purchaseStatus.map((e) => e.value!).toList();
}

List<enums.PurchaseStatus> purchaseStatusListFromJson(
  List? purchaseStatus, [
  List<enums.PurchaseStatus>? defaultValue,
]) {
  if (purchaseStatus == null) {
    return defaultValue ?? [];
  }

  return purchaseStatus
      .map((e) => purchaseStatusFromJson(e.toString()))
      .toList();
}

List<enums.PurchaseStatus>? purchaseStatusNullableListFromJson(
  List? purchaseStatus, [
  List<enums.PurchaseStatus>? defaultValue,
]) {
  if (purchaseStatus == null) {
    return defaultValue;
  }

  return purchaseStatus
      .map((e) => purchaseStatusFromJson(e.toString()))
      .toList();
}

String? paymentTypeNullableToJson(enums.PaymentType? paymentType) {
  return paymentType?.value;
}

String? paymentTypeToJson(enums.PaymentType paymentType) {
  return paymentType.value;
}

enums.PaymentType paymentTypeFromJson(
  Object? paymentType, [
  enums.PaymentType? defaultValue,
]) {
  return enums.PaymentType.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            paymentType?.toString().toLowerCase(),
      ) ??
      defaultValue ??
      enums.PaymentType.swaggerGeneratedUnknown;
}

enums.PaymentType? paymentTypeNullableFromJson(
  Object? paymentType, [
  enums.PaymentType? defaultValue,
]) {
  if (paymentType == null) {
    return null;
  }
  return enums.PaymentType.values.firstWhereOrNull(
        (e) =>
            e.value.toString().toLowerCase() ==
            paymentType.toString().toLowerCase(),
      ) ??
      defaultValue;
}

String paymentTypeExplodedListToJson(List<enums.PaymentType>? paymentType) {
  return paymentType?.map((e) => e.value!).join(',') ?? '';
}

List<String> paymentTypeListToJson(List<enums.PaymentType>? paymentType) {
  if (paymentType == null) {
    return [];
  }

  return paymentType.map((e) => e.value!).toList();
}

List<enums.PaymentType> paymentTypeListFromJson(
  List? paymentType, [
  List<enums.PaymentType>? defaultValue,
]) {
  if (paymentType == null) {
    return defaultValue ?? [];
  }

  return paymentType.map((e) => paymentTypeFromJson(e.toString())).toList();
}

List<enums.PaymentType>? paymentTypeNullableListFromJson(
  List? paymentType, [
  List<enums.PaymentType>? defaultValue,
]) {
  if (paymentType == null) {
    return defaultValue;
  }

  return paymentType.map((e) => paymentTypeFromJson(e.toString())).toList();
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
