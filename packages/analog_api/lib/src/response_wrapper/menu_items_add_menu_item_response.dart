// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/menu_item_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class MenuItemsAddMenuItemResponse {
  const MenuItemsAddMenuItemResponse();
}

@_i1.immutable
class MenuItemsAddMenuItemResponse201 extends MenuItemsAddMenuItemResponse {
  const MenuItemsAddMenuItemResponse201({required this.body});

  final _i2.MenuItemResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemsAddMenuItemResponse201 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class MenuItemsAddMenuItemResponse401 extends MenuItemsAddMenuItemResponse {
  const MenuItemsAddMenuItemResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemsAddMenuItemResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
