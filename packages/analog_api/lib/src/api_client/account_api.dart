// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i13;

import 'package:analog_api/src/model/complete_registration_request.dart'
    as _i23;
import 'package:analog_api/src/model/email_exists_request.dart' as _i25;
import 'package:analog_api/src/model/register_account_request.dart' as _i20;
import 'package:analog_api/src/model/resend_account_verification_email_request.dart'
    as _i29;
import 'package:analog_api/src/model/token_login_request.dart' as _i34;
import 'package:analog_api/src/model/update_user_group_request.dart' as _i27;
import 'package:analog_api/src/model/update_user_request.dart' as _i18;
import 'package:analog_api/src/model/user_login_request.dart' as _i32;
import 'package:analog_api/src/operation/account_authenticate.dart' as _i12;
import 'package:analog_api/src/operation/account_complete_registration.dart'
    as _i6;
import 'package:analog_api/src/operation/account_delete.dart' as _i5;
import 'package:analog_api/src/operation/account_email_exists.dart' as _i7;
import 'package:analog_api/src/operation/account_get.dart' as _i2;
import 'package:analog_api/src/operation/account_login.dart' as _i11;
import 'package:analog_api/src/operation/account_register.dart' as _i4;
import 'package:analog_api/src/operation/account_resend_verification_email.dart'
    as _i9;
import 'package:analog_api/src/operation/account_search_users.dart' as _i10;
import 'package:analog_api/src/operation/account_update.dart' as _i3;
import 'package:analog_api/src/operation/account_update_account_user_group.dart'
    as _i8;
import 'package:analog_api/src/response_wrapper/account_authenticate_response.dart'
    as _i33;
import 'package:analog_api/src/response_wrapper/account_complete_registration_response.dart'
    as _i22;
import 'package:analog_api/src/response_wrapper/account_delete_response.dart'
    as _i21;
import 'package:analog_api/src/response_wrapper/account_email_exists_response.dart'
    as _i24;
import 'package:analog_api/src/response_wrapper/account_get_response.dart'
    as _i15;
import 'package:analog_api/src/response_wrapper/account_login_response.dart'
    as _i31;
import 'package:analog_api/src/response_wrapper/account_register_response.dart'
    as _i19;
import 'package:analog_api/src/response_wrapper/account_resend_verification_email_response.dart'
    as _i28;
import 'package:analog_api/src/response_wrapper/account_search_users_response.dart'
    as _i30;
import 'package:analog_api/src/response_wrapper/account_update_account_user_group_response.dart'
    as _i26;
import 'package:analog_api/src/response_wrapper/account_update_response.dart'
    as _i17;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i16;
import 'package:tonik_util/tonik_util.dart' as _i14;

class AccountApi {
  AccountApi(_i1.Server server)
    : _accountGet = _i2.AccountGet(server.baseUrl, () => server.dio),
      _accountUpdate = _i3.AccountUpdate(server.baseUrl, () => server.dio),
      _accountRegister = _i4.AccountRegister(server.baseUrl, () => server.dio),
      _accountDelete = _i5.AccountDelete(server.baseUrl, () => server.dio),
      _accountCompleteRegistration = _i6.AccountCompleteRegistration(
        server.baseUrl,
        () => server.dio,
      ),
      _accountEmailExists = _i7.AccountEmailExists(
        server.baseUrl,
        () => server.dio,
      ),
      _accountUpdateAccountUserGroup = _i8.AccountUpdateAccountUserGroup(
        server.baseUrl,
        () => server.dio,
      ),
      _accountResendVerificationEmail = _i9.AccountResendVerificationEmail(
        server.baseUrl,
        () => server.dio,
      ),
      _accountSearchUsers = _i10.AccountSearchUsers(
        server.baseUrl,
        () => server.dio,
      ),
      _accountLogin = _i11.AccountLogin(server.baseUrl, () => server.dio),
      _accountAuthenticate = _i12.AccountAuthenticate(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.AccountGet _accountGet;

  final _i3.AccountUpdate _accountUpdate;

  final _i4.AccountRegister _accountRegister;

  final _i5.AccountDelete _accountDelete;

  final _i6.AccountCompleteRegistration _accountCompleteRegistration;

  final _i7.AccountEmailExists _accountEmailExists;

  final _i8.AccountUpdateAccountUserGroup _accountUpdateAccountUserGroup;

  final _i9.AccountResendVerificationEmail _accountResendVerificationEmail;

  final _i10.AccountSearchUsers _accountSearchUsers;

  final _i11.AccountLogin _accountLogin;

  final _i12.AccountAuthenticate _accountAuthenticate;

  /// Returns basic data about the account
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i13.Future<
    _i14.TonikResult<_i15.AccountGetResponse, _i16.Response<_i13.Object?>>
  >
  accountGet({_i14.TonikCancellation? cancellation}) async =>
      this._accountGet(cancellation: cancellation);

  /// Updates the account and returns the updated values.
  /// Only properties which are present in the CoffeeCard.Models.DataTransferObjects.v2.User.UpdateUserRequest will be updated
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i13.Future<
    _i14.TonikResult<_i17.AccountUpdateResponse, _i16.Response<_i13.Object?>>
  >
  accountUpdate({
    required _i18.UpdateUserRequest body,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountUpdate(body: body, cancellation: cancellation);

  /// Register data request. An account is required to verify its email before logging in
  /// Legacy endpoint kept for the old app. It returns 409 for an existing
  /// email, so unlike /login it can be used to probe account existence.
  /// Remove it when the old app is retired.
  _i13.Future<
    _i14.TonikResult<_i19.AccountRegisterResponse, _i16.Response<_i13.Object?>>
  >
  accountRegister({
    required _i20.RegisterAccountRequest body,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountRegister(body: body, cancellation: cancellation);

  /// Request the deletion of the user coupled to the provided token
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i13.Future<
    _i14.TonikResult<_i21.AccountDeleteResponse, _i16.Response<_i13.Object?>>
  >
  accountDelete({_i14.TonikCancellation? cancellation}) async =>
      this._accountDelete(cancellation: cancellation);

  /// Complete a registration that was started from an app login request.
  /// The email is read from the single-use token, not from the request body.
  _i13.Future<
    _i14.TonikResult<
      _i22.AccountCompleteRegistrationResponse,
      _i16.Response<_i13.Object?>
    >
  >
  accountCompleteRegistration({
    required _i23.CompleteRegistrationRequest body,
    _i14.TonikCancellation? cancellation,
  }) async =>
      this._accountCompleteRegistration(body: body, cancellation: cancellation);

  /// Check if a given email is in use
  /// Legacy endpoint used by the old app. This is an explicit
  /// account-existence oracle and should be removed with the old app.
  _i13.Future<
    _i14.TonikResult<
      _i24.AccountEmailExistsResponse,
      _i16.Response<_i13.Object?>
    >
  >
  accountEmailExists({
    required _i25.EmailExistsRequest body,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountEmailExists(body: body, cancellation: cancellation);

  /// Updates the user group of a user
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i13.Future<
    _i14.TonikResult<
      _i26.AccountUpdateAccountUserGroupResponse,
      _i16.Response<_i13.Object?>
    >
  >
  accountUpdateAccountUserGroup({
    required _i27.UpdateUserGroupRequest body,
    required _i13.int id,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountUpdateAccountUserGroup(
    body: body,
    id: id,
    cancellation: cancellation,
  );

  /// Resend account verification email if account is not already verified
  _i13.Future<
    _i14.TonikResult<
      _i28.AccountResendVerificationEmailResponse,
      _i16.Response<_i13.Object?>
    >
  >
  accountResendVerificationEmail({
    required _i29.ResendAccountVerificationEmailRequest body,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountResendVerificationEmail(
    body: body,
    cancellation: cancellation,
  );

  /// Searches a user in the database
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i13.Future<
    _i14.TonikResult<
      _i30.AccountSearchUsersResponse,
      _i16.Response<_i13.Object?>
    >
  >
  accountSearchUsers({
    _i13.int? pageNum,
    _i13.String filter = _i10.AccountSearchUsers.filterDefault,
    _i13.int pageLength = _i10.AccountSearchUsers.pageLengthDefault,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountSearchUsers(
    pageNum: pageNum,
    filter: filter,
    pageLength: pageLength,
    cancellation: cancellation,
  );

  /// Sends a magic link to the user's email to login
  _i13.Future<
    _i14.TonikResult<_i31.AccountLoginResponse, _i16.Response<_i13.Object?>>
  >
  accountLogin({
    required _i32.UserLoginRequest body,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountLogin(body: body, cancellation: cancellation);

  /// Authenticates the user with the token hash from a magic link
  _i13.Future<
    _i14.TonikResult<
      _i33.AccountAuthenticateResponse,
      _i16.Response<_i13.Object?>
    >
  >
  accountAuthenticate({
    required _i34.TokenLoginRequest body,
    _i14.TonikCancellation? cancellation,
  }) async => this._accountAuthenticate(body: body, cancellation: cancellation);
}
