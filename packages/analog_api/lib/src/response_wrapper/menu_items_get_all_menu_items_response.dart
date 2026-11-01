// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/menu_item_response.dart' as _i3;
import 'package:collection/collection.dart' as _i4;
import 'package:meta/meta.dart' as _i1;

sealed class MenuItemsGetAllMenuItemsResponse {
  const MenuItemsGetAllMenuItemsResponse();
}

@_i1.immutable
class MenuItemsGetAllMenuItemsResponse200
    extends MenuItemsGetAllMenuItemsResponse {
  const MenuItemsGetAllMenuItemsResponse200({required this.body});

  final _i2.List<_i3.MenuItemResponse> body;

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    const _$deepEquals = _i4.DeepCollectionEquality();
    return other is MenuItemsGetAllMenuItemsResponse200 &&
        _$deepEquals.equals(other.body, this.body);
  }

  @_i2.override
  _i2.int get hashCode {
    const deepEquals = _i4.DeepCollectionEquality();
    return deepEquals.hash(this.body);
  }
}

@_i1.immutable
class MenuItemsGetAllMenuItemsResponse401
    extends MenuItemsGetAllMenuItemsResponse {
  const MenuItemsGetAllMenuItemsResponse401();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is MenuItemsGetAllMenuItemsResponse401;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}

@_i1.immutable
class MenuItemsGetAllMenuItemsResponse403
    extends MenuItemsGetAllMenuItemsResponse {
  const MenuItemsGetAllMenuItemsResponse403();

  @_i2.override
  _i2.bool operator ==(_i2.Object other) {
    if (_i2.identical(this, other)) return true;
    return other is MenuItemsGetAllMenuItemsResponse403;
  }

  @_i2.override
  _i2.int get hashCode => this.runtimeType.hashCode;
}
