import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text('My Profit (RM)',
                          style: TextStyle(
                              color: AppColors.text,
                              fontWeight: FontWeight.w900,
                              fontSize: 21)),
                      Text('0.00',
                          style: TextStyle(
                              color: AppColors.success,
                              fontWeight: FontWeight.w100,
                              fontSize: 32)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('All Products:-',
                      style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 190.0), child: Divider(thickness: 1.0,)),
              Expanded(
                child: DataSingleton.shared.productData == null || DataSingleton.shared.productData.data.isEmpty ? Center(child: Text('Products Not Found', style: TextStyle(fontSize: 20.0)),) : ListView.builder(
                  primary: false,
                  itemCount: DataSingleton.shared.productData.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: Card(
                        child: ListTile(
                          title: Text(DataSingleton.shared.productData.data[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            children: [
                              Badge(
                                elevation: 0,
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: AppColors.info,
                                borderRadius: BorderRadius.circular(4),
                                badgeContent: Text('Stock Qty: '+DataSingleton.shared.productData.data[index].stockQty.toString(), style: TextStyle(color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.bold))
                              ),
                              SizedBox(width: 2.0,),
                              Badge(
                                elevation: 0,
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: DataSingleton.shared.productData.data[index].isActive == 1 ? Colors.green : Colors.amber,
                                borderRadius: BorderRadius.circular(4),
                                badgeContent: DataSingleton.shared.productData.data[index].isActive == 1 ? Text('Active', style: TextStyle(color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.bold)) : Text('Inactive', style: TextStyle(color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          trailing: Text(DataSingleton.shared.productData.data[index].currencySymbol+' '+DataSingleton.shared.productData.data[index].salesPrice, style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold)),
                          onTap: () {
                            onTapClicked(DataSingleton.shared.productData.data[index].id); 
                          },
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}