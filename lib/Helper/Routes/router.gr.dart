// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sbit_mobile/Class/AppRoot/app_root.dart';
import 'package:sbit_mobile/Class/Home/home.dart';
import 'package:sbit_mobile/Class/Product/new_product.dart';
import 'package:sbit_mobile/Class/Product/details_product.dart';

abstract class Routes {
  static const approot = '/';
  static const home = '/home';
  static const newProduct = '/new-product';
  static const detailsProduct = '/details-product';
  static const all = {
    approot,
    home,
    newProduct,
    detailsProduct,
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
