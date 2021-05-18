import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
// import 'package:sbit_mobile/Helper/Component/drawer.dart';
import 'package:sbit_mobile/Helper/Component/navbar.dart';
import 'package:sbit_mobile/Helper/GlobalVariable/global_variable.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
import 'package:sbit_mobile/Model/data_singleton.dart';
import 'package:sbit_mobile/Model/product.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;

ApiManager apiManager;

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final costCtrl = TextEditingController();

  //===================================== [START] API SERVICES ===================================================//
 
  Future onListProducts(String mid) async {
    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.listProducts(mid).then((res) {
      Navigator.of(context).pop();
      onReadResponse(true, res);
    }).catchError((res) {
      Navigator.of(context).pop();
      onReadResponse(false, res);
    });
  }

  //===================================== [END] API SERVICES ===================================================//
  
  void onReadResponse(bool status, res) {
    if (status) {
      if (res['code'] == 200) {
        setState(() {
          DataSingleton.shared.productData = Product.fromJson(res);
        });
      }
    } else {
      // error status, enhance later
    }
  }

  onTapClicked(int id) {
    ExtendedNavigator.ofRouter<ModuleRouter.Router>().pushNamed(ModuleRouter.Routes.detailsProduct, arguments: DetailsProductArguments(productId: id));
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
    Helper.instance.checkInternet().then((intenet) {
      if(intenet != null && intenet) {
        onListProducts(GlobalVariable.merchantID);
      } else {
        DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
      }
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: Navbar(
          title: 'Dashboard',
          noShadow: true,
          onTapOne: () { 
            ExtendedNavigator.ofRouter<ModuleRouter.Router>()
            .pushNamed(ModuleRouter.Routes.newProduct).then((value) {
              Helper.instance.checkInternet().then((intenet) {
                if(intenet != null && intenet) {
                  onListProducts(GlobalVariable.merchantID);
                } else {
                  DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
                }
              });
            });
          },
        ),
        // drawer: ArgonDrawer(currentPage: 'Dashboard'),
        body: SafeArea(
          child: Container(
            
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}