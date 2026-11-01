// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/menu_item_response.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class MenuItemsUpdateMenuItemResponse {
  const MenuItemsUpdateMenuItemResponse();
}

@_i1.immutable
class MenuItemsUpdateMenuItemResponse200
    extends MenuItemsUpdateMenuItemResponse {
  const MenuItemsUpdateMenuItemResponse200({required this.body});

  final _i2.MenuItemResponse body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemsUpdateMenuItemResponse200 &&
        other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class MenuItemsUpdateMenuItemResponse401
    extends MenuItemsUpdateMenuItemResponse {
  const MenuItemsUpdateMenuItemResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemsUpdateMenuItemResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class MenuItemsUpdateMenuItemResponse404
    extends MenuItemsUpdateMenuItemResponse {
  const MenuItemsUpdateMenuItemResponse404();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemsUpdateMenuItemResponse404;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class MenuItemsUpdateMenuItemResponse409
    extends MenuItemsUpdateMenuItemResponse {
  const MenuItemsUpdateMenuItemResponse409();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemsUpdateMenuItemResponse409;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
