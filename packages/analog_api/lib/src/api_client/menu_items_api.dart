// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i5;

import 'package:analog_api/src/model/add_menu_item_request.dart' as _i10;
import 'package:analog_api/src/model/update_menu_item_request.dart' as _i12;
import 'package:analog_api/src/operation/menu_items_add_menu_item.dart' as _i3;
import 'package:analog_api/src/operation/menu_items_get_all_menu_items.dart'
    as _i2;
import 'package:analog_api/src/operation/menu_items_update_menu_item.dart'
    as _i4;
import 'package:analog_api/src/response_wrapper/menu_items_add_menu_item_response.dart'
    as _i9;
import 'package:analog_api/src/response_wrapper/menu_items_get_all_menu_items_response.dart'
    as _i7;
import 'package:analog_api/src/response_wrapper/menu_items_update_menu_item_response.dart'
    as _i11;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i8;
import 'package:tonik_util/tonik_util.dart' as _i6;

class MenuItemsApi {
  MenuItemsApi(_i1.Server server)
    : _menuItemsGetAllMenuItems = _i2.MenuItemsGetAllMenuItems(
        server.baseUrl,
        () => server.dio,
      ),
      _menuItemsAddMenuItem = _i3.MenuItemsAddMenuItem(
        server.baseUrl,
        () => server.dio,
      ),
      _menuItemsUpdateMenuItem = _i4.MenuItemsUpdateMenuItem(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.MenuItemsGetAllMenuItems _menuItemsGetAllMenuItems;

  final _i3.MenuItemsAddMenuItem _menuItemsAddMenuItem;

  final _i4.MenuItemsUpdateMenuItem _menuItemsUpdateMenuItem;

  /// Returns a list of all menu items
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i5.Future<
    _i6.TonikResult<
      _i7.MenuItemsGetAllMenuItemsResponse,
      _i8.Response<_i5.Object?>
    >
  >
  menuItemsGetAllMenuItems({_i6.TonikCancellation? cancellation}) async =>
      this._menuItemsGetAllMenuItems(cancellation: cancellation);

  /// Adds a menu item
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i5.Future<
    _i6.TonikResult<_i9.MenuItemsAddMenuItemResponse, _i8.Response<_i5.Object?>>
  >
  menuItemsAddMenuItem({
    required _i10.AddMenuItemRequest body,
    _i6.TonikCancellation? cancellation,
  }) async =>
      this._menuItemsAddMenuItem(body: body, cancellation: cancellation);

  /// Updates a menu item
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i5.Future<
    _i6.TonikResult<
      _i11.MenuItemsUpdateMenuItemResponse,
      _i8.Response<_i5.Object?>
    >
  >
  menuItemsUpdateMenuItem({
    required _i12.UpdateMenuItemRequest body,
    required _i5.int id,
    _i6.TonikCancellation? cancellation,
  }) async => this._menuItemsUpdateMenuItem(
    body: body,
    id: id,
    cancellation: cancellation,
  );
}
