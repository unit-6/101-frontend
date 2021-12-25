// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../Class/AppRoot/app_root.dart' as _i1;
import '../../Class/Dashboard/dashboard.dart' as _i3;
import '../../Class/Home/home.dart' as _i2;
import '../../Class/Product/details_product.dart' as _i5;
import '../../Class/Product/edit_product.dart' as _i6;
import '../../Class/Product/new_product.dart' as _i4;
import '../../Class/Sales/sales.dart' as _i7;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AppRoot.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.AppRoot());
    },
    Home.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.Home());
    },
    Dashboard.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.Dashboard());
    },
    NewProduct.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.NewProduct());
    },
    DetailsProduct.name: (routeData) {
      final args = routeData.argsAs<DetailsProductArgs>(
          orElse: () => const DetailsProductArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.DetailsProduct(key: args.key, productId: args.productId));
    },
    EditProduct.name: (routeData) {
      final args = routeData.argsAs<EditProductArgs>(
          orElse: () => const EditProductArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.EditProduct(
              key: args.key,
              vProdName: args.vProdName,
              vSalesPrice: args.vSalesPrice,
              vStockQty: args.vStockQty,
              vId: args.vId,
              vIsActive: args.vIsActive,
              vCurrencyCode: args.vCurrencyCode,
              vCurrencySymbol: args.vCurrencySymbol));
    },
    Sales.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.Sales());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(AppRoot.name, path: '/'),
        _i8.RouteConfig(Home.name, path: '/Home'),
        _i8.RouteConfig(Dashboard.name, path: '/Dashboard'),
        _i8.RouteConfig(NewProduct.name, path: '/new-product'),
        _i8.RouteConfig(DetailsProduct.name, path: '/details-product'),
        _i8.RouteConfig(EditProduct.name, path: '/edit-product'),
        _i8.RouteConfig(Sales.name, path: '/Sales')
      ];
}

/// generated route for
/// [_i1.AppRoot]
class AppRoot extends _i8.PageRouteInfo<void> {
  const AppRoot() : super(AppRoot.name, path: '/');

  static const String name = 'AppRoot';
}

/// generated route for
/// [_i2.Home]
class Home extends _i8.PageRouteInfo<void> {
  const Home() : super(Home.name, path: '/Home');

  static const String name = 'Home';
}

/// generated route for
/// [_i3.Dashboard]
class Dashboard extends _i8.PageRouteInfo<void> {
  const Dashboard() : super(Dashboard.name, path: '/Dashboard');

  static const String name = 'Dashboard';
}

/// generated route for
/// [_i4.NewProduct]
class NewProduct extends _i8.PageRouteInfo<void> {
  const NewProduct() : super(NewProduct.name, path: '/new-product');

  static const String name = 'NewProduct';
}

/// generated route for
/// [_i5.DetailsProduct]
class DetailsProduct extends _i8.PageRouteInfo<DetailsProductArgs> {
  DetailsProduct({_i9.Key? key, int? productId})
      : super(DetailsProduct.name,
            path: '/details-product',
            args: DetailsProductArgs(key: key, productId: productId));

  static const String name = 'DetailsProduct';
}

class DetailsProductArgs {
  const DetailsProductArgs({this.key, this.productId});

  final _i9.Key? key;

  final int? productId;

  @override
  String toString() {
    return 'DetailsProductArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i6.EditProduct]
class EditProduct extends _i8.PageRouteInfo<EditProductArgs> {
  EditProduct(
      {_i9.Key? key,
      String? vProdName,
      String? vSalesPrice,
      int? vStockQty,
      int? vId,
      int? vIsActive,
      String? vCurrencyCode,
      String? vCurrencySymbol})
      : super(EditProduct.name,
            path: '/edit-product',
            args: EditProductArgs(
                key: key,
                vProdName: vProdName,
                vSalesPrice: vSalesPrice,
                vStockQty: vStockQty,
                vId: vId,
                vIsActive: vIsActive,
                vCurrencyCode: vCurrencyCode,
                vCurrencySymbol: vCurrencySymbol));

  static const String name = 'EditProduct';
}

class EditProductArgs {
  const EditProductArgs(
      {this.key,
      this.vProdName,
      this.vSalesPrice,
      this.vStockQty,
      this.vId,
      this.vIsActive,
      this.vCurrencyCode,
      this.vCurrencySymbol});

  final _i9.Key? key;

  final String? vProdName;

  final String? vSalesPrice;

  final int? vStockQty;

  final int? vId;

  final int? vIsActive;

  final String? vCurrencyCode;

  final String? vCurrencySymbol;

  @override
  String toString() {
    return 'EditProductArgs{key: $key, vProdName: $vProdName, vSalesPrice: $vSalesPrice, vStockQty: $vStockQty, vId: $vId, vIsActive: $vIsActive, vCurrencyCode: $vCurrencyCode, vCurrencySymbol: $vCurrencySymbol}';
  }
}

/// generated route for
/// [_i7.Sales]
class Sales extends _i8.PageRouteInfo<void> {
  const Sales() : super(Sales.name, path: '/Sales');

  static const String name = 'Sales';
}
