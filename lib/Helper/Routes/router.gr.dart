// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../Class/AppRoot/app_root.dart' as _i3;
import '../../Class/Dashboard/dashboard.dart' as _i5;
import '../../Class/Home/home.dart' as _i4;
import '../../Class/Product/details_product.dart' as _i7;
import '../../Class/Product/edit_product.dart' as _i8;
import '../../Class/Product/new_product.dart' as _i6;
import '../../Class/Sales/sales.dart' as _i9;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    AppRoot.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.AppRoot();
        }),
    Home.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.Home();
        }),
    Dashboard.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.Dashboard();
        }),
    NewProduct.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.NewProduct();
        }),
    DetailsProduct.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DetailsProductArgs>(
              orElse: () => const DetailsProductArgs());
          return _i7.DetailsProduct(key: args.key, productId: args.productId);
        }),
    EditProduct.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<EditProductArgs>(
              orElse: () => const EditProductArgs());
          return _i8.EditProduct(
              key: args.key,
              vProdName: args.vProdName,
              vSalesPrice: args.vSalesPrice,
              vStockQty: args.vStockQty,
              vId: args.vId,
              vIsActive: args.vIsActive,
              vCurrencyCode: args.vCurrencyCode,
              vCurrencySymbol: args.vCurrencySymbol);
        }),
    Sales.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.Sales();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(AppRoot.name, path: '/'),
        _i1.RouteConfig(Home.name, path: '/Home'),
        _i1.RouteConfig(Dashboard.name, path: '/Dashboard'),
        _i1.RouteConfig(NewProduct.name, path: '/new-product'),
        _i1.RouteConfig(DetailsProduct.name, path: '/details-product'),
        _i1.RouteConfig(EditProduct.name, path: '/edit-product'),
        _i1.RouteConfig(Sales.name, path: '/Sales')
      ];
}

class AppRoot extends _i1.PageRouteInfo {
  const AppRoot() : super(name, path: '/');

  static const String name = 'AppRoot';
}

class Home extends _i1.PageRouteInfo {
  const Home() : super(name, path: '/Home');

  static const String name = 'Home';
}

class Dashboard extends _i1.PageRouteInfo {
  const Dashboard() : super(name, path: '/Dashboard');

  static const String name = 'Dashboard';
}

class NewProduct extends _i1.PageRouteInfo {
  const NewProduct() : super(name, path: '/new-product');

  static const String name = 'NewProduct';
}

class DetailsProduct extends _i1.PageRouteInfo<DetailsProductArgs> {
  DetailsProduct({_i2.Key? key, int? productId})
      : super(name,
            path: '/details-product',
            args: DetailsProductArgs(key: key, productId: productId));

  static const String name = 'DetailsProduct';
}

class DetailsProductArgs {
  const DetailsProductArgs({this.key, this.productId});

  final _i2.Key? key;

  final int? productId;
}

class EditProduct extends _i1.PageRouteInfo<EditProductArgs> {
  EditProduct(
      {_i2.Key? key,
      String? vProdName,
      String? vSalesPrice,
      int? vStockQty,
      int? vId,
      int? vIsActive,
      String? vCurrencyCode,
      String? vCurrencySymbol})
      : super(name,
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

  final _i2.Key? key;

  final String? vProdName;

  final String? vSalesPrice;

  final int? vStockQty;

  final int? vId;

  final int? vIsActive;

  final String? vCurrencyCode;

  final String? vCurrencySymbol;
}

class Sales extends _i1.PageRouteInfo {
  const Sales() : super(name, path: '/Sales');

  static const String name = 'Sales';
}
