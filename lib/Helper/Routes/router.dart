// ##### NEED TO RUN TO GENERATE ROUTES ######
// flutter packages pub run build_runner watch
// ###########################################

import 'package:auto_route/auto_route_annotations.dart';
import 'package:sbit_mobile/Class/AppRoot/app_root.dart';
import 'package:sbit_mobile/Class/Home/home.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  AppRoot approot;
  Home home;
}