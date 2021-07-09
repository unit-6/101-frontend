// ##### NEED TO RUN TO GENERATE ROUTES ######
// flutter packages pub run build_runner watch --delete-conflicting-outputs
// ###########################################

import 'package:auto_route/annotations.dart';
import 'package:sbit_mobile/Class/AppRoot/app_root.dart';
import 'package:sbit_mobile/Class/Dashboard/dashboard.dart';
import 'package:sbit_mobile/Class/Home/home.dart';
import 'package:sbit_mobile/Class/Product/details_product.dart';
import 'package:sbit_mobile/Class/Product/edit_product.dart';
import 'package:sbit_mobile/Class/Product/new_product.dart';
import 'package:sbit_mobile/Class/Sales/sales.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[  
    AutoRoute(page: AppRoot, initial: true),
    AutoRoute(page: Home),
    AutoRoute(page: Dashboard),
    AutoRoute(page: NewProduct),
    AutoRoute(page: DetailsProduct),
    AutoRoute(page: EditProduct),
    AutoRoute(page: Sales),
  ],  
)  
class $AppRouter {}  