// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sbit_mobile/Class/AppRoot/app_root.dart';
import 'package:sbit_mobile/Class/Home/home.dart';
import 'package:sbit_mobile/Class/Dashboard/dashboard.dart';
import 'package:sbit_mobile/Class/Product/new_product.dart';
import 'package:sbit_mobile/Class/Product/details_product.dart';
import 'package:sbit_mobile/Class/Product/edit_product.dart';
import 'package:sbit_mobile/Class/Sales/sales.dart';

abstract class Routes {
  static const approot = '/';
  static const home = '/home';
  static const dashboard = '/dashboard';
  static const newProduct = '/new-product';
  static const detailsProduct = '/details-product';
  static const editProduct = '/edit-product';
  static const sales = '/sales';
  static const all = {
    approot,
    home,
    dashboard,
    newProduct,
    detailsProduct,
    editProduct,
    sales,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.approot:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AppRoot(),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Home(),
          settings: settings,
        );
      case Routes.dashboard:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Dashboard(),
          settings: settings,
        );
      case Routes.newProduct:
        return MaterialPageRoute<dynamic>(
          builder: (context) => NewProduct(),
          settings: settings,
        );
      case Routes.detailsProduct:
        if (hasInvalidArgs<DetailsProductArguments>(args)) {
          return misTypedArgsRoute<DetailsProductArguments>(args);
        }
        final typedArgs =
            args as DetailsProductArguments ?? DetailsProductArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => DetailsProduct(
              key: typedArgs.key, productId: typedArgs.productId),
          settings: settings,
        );
      case Routes.editProduct:
        if (hasInvalidArgs<EditProductArguments>(args)) {
          return misTypedArgsRoute<EditProductArguments>(args);
        }
        final typedArgs =
            args as EditProductArguments ?? EditProductArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => EditProduct(
              key: typedArgs.key,
              vProdName: typedArgs.vProdName,
              vSalesPrice: typedArgs.vSalesPrice,
              vStockQty: typedArgs.vStockQty,
              vId: typedArgs.vId,
              vIsActive: typedArgs.vIsActive,
              vCurrencyCode: typedArgs.vCurrencyCode,
              vCurrencySymbol: typedArgs.vCurrencySymbol),
          settings: settings,
        );
      case Routes.sales:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Sales(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//DetailsProduct arguments holder class
class DetailsProductArguments {
  final Key key;
  final int productId;
  DetailsProductArguments({this.key, this.productId});
}

//EditProduct arguments holder class
class EditProductArguments {
  final Key key;
  final String vProdName;
  final String vSalesPrice;
  final int vStockQty;
  final int vId;
  final int vIsActive;
  final String vCurrencyCode;
  final String vCurrencySymbol;
  EditProductArguments(
      {this.key,
      this.vProdName,
      this.vSalesPrice,
      this.vStockQty,
      this.vId,
      this.vIsActive,
      this.vCurrencyCode,
      this.vCurrencySymbol});
}
