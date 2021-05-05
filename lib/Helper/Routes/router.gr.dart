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

abstract class Routes {
  static const approot = '/';
  static const home = '/home';
  static const newProduct = '/new-product';
  static const all = {
    approot,
    home,
    newProduct,
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
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
