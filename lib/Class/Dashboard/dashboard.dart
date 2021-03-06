import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
import 'package:sbit_mobile/Helper/Component/input.dart';
// import 'package:sbit_mobile/Helper/Component/drawer.dart';
import 'package:sbit_mobile/Helper/Component/navbar.dart';
import 'package:sbit_mobile/Helper/GlobalVariable/global_variable.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
import 'package:sbit_mobile/Model/data_singleton.dart';
import 'package:sbit_mobile/Model/product.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;

late ApiManager apiManager;
bool? isListProducts;
bool? isStartSales;

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final costCtrl = TextEditingController();

  //===================================== [START] API SERVICES ===================================================//
 
  Future onListProducts(String? mid) async {

    isListProducts = true;
    isStartSales = false;

    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.listProducts(mid).then((res) {
      Navigator.of(context).pop();
      onReadResponse(true, res);
    }).catchError((res) {
      Navigator.of(context).pop();
      onReadResponse(false, res);
    });
  }

  Future onStartSales(String cost, String currencyCode, String currencySymbol, String? mid) async {

    isListProducts = false;
    isStartSales = true;

    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.startSales(cost, currencyCode, currencySymbol, mid).then((res) {
      Navigator.of(context).pop();
      onReadResponse(true, res);
    }).catchError((res) {
      Navigator.of(context).pop();
      onReadResponse(false, res);
    });
  }

  //===================================== [END] API SERVICES ===================================================//
  
  void onReadResponse(bool status, res) {
    if(isListProducts == true){
      if (status) {
        if (res['code'] == 200) {
          setState(() {
            DataSingleton.shared.productData = Product.fromJson(res);
          });

          if(GlobalVariable.salesStatus != null) {
            if(GlobalVariable.salesStatus == 1) {

              // ExtendedNavigator.ofRouter<ModuleRouter.Router>()
              // .pushNamed(ModuleRouter.Routes.sales).then((value) {
              //   Helper.instance.checkInternet().then((intenet) {
              //     if(intenet != null && intenet) {
              //       onListProducts(GlobalVariable.merchantID);
              //     } else {
              //       DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
              //     }
              //   });
              // });

              AutoRouter.of(context).push(ModuleRouter.Sales()).then((value) {
                Helper.instance.checkInternet().then((intenet) {
                  if(intenet) {
                    onListProducts(GlobalVariable.merchantID);
                  } else {
                    DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
                  }
                });
              });
            }
          }
        }
      } else {
        // error status, enhance later
      }
    } 
    if(isStartSales == true) {
      if (status) {
        if (res['code'] == 200) {
          debugPrint(res['message']);

          GlobalVariable().addSalesID('key_sales_id', res['sale_id'].toString());
          GlobalVariable.salesID = res['sale_id'];

          GlobalVariable().addSalesStatus('key_sales_status', res['status'].toString());
          GlobalVariable.salesStatus = res['status'];

          // ExtendedNavigator.ofRouter<ModuleRouter.Router>()
          //   .pushNamed(ModuleRouter.Routes.sales).then((value) {
          //     Helper.instance.checkInternet().then((intenet) {
          //       if(intenet != null && intenet) {
          //         onListProducts(GlobalVariable.merchantID);
          //       } else {
          //         DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
          //       }
          //     });
          //   });

          AutoRouter.of(context).push(ModuleRouter.Sales()).then((value) {
            Helper.instance.checkInternet().then((intenet) {
              if(intenet) {
                onListProducts(GlobalVariable.merchantID);
              } else {
                DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
              }
            });
          });
        }
      } else {
        // error status, enhance later
      }
    }
  }

  onTapClicked(int? id) {
    // ExtendedNavigator.ofRouter<ModuleRouter.Router>()
    //   .pushNamed(ModuleRouter.Routes.detailsProduct, arguments: DetailsProductArguments(productId: id)).then((value) {
    //     Helper.instance.checkInternet().then((intenet) {
    //       if(intenet != null && intenet) {
    //         onListProducts(GlobalVariable.merchantID);
    //       } else {
    //         DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
    //       }
    //     });
    //   });

    AutoRouter.of(context).push(ModuleRouter.DetailsProduct(productId: id)).then((value) {
      Helper.instance.checkInternet().then((intenet) {
        if(intenet) {
          onListProducts(GlobalVariable.merchantID);
        } else {
          DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
        }
      });
    });
  }

  onPressed(String status) {
    if(status == 'startsales') {
      debugPrint('startsales clicked');
      DialogHelper.inputDialog(
        context,
          'Start Sales',
          'Enter your current cost (RM)',
        () => { Navigator.of(context).pop() },
        () { 
          Navigator.of(context).pop();
          if(costCtrl.text.isNotEmpty) {
            debugPrint('costCtrl=${costCtrl.text}');
            Helper.instance.checkInternet().then((intenet) {
            if(intenet) {
              onStartSales(
                costCtrl.text,
                'MYR',
                'RM',
                GlobalVariable.merchantID
              );
            } else {
              DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
            }
          });
          }
          else {
            DialogHelper.customDialog(context, 'Empty Field', 'Please enter empty field', () => { Navigator.of(context).pop() });
          }
        },
        Input(
          placeholder: 'e.g. 2.70, 3.20, 60.0',
          controller: costCtrl,
          keyboardType: 03,
          textInputAction: 01,
          autofocus: true,
          onChanged: (value) => {},
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);

    isListProducts = false;
    isStartSales = false;

    Helper.instance.checkInternet().then((intenet) {
      if(intenet) {
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
            AutoRouter.of(context).push(ModuleRouter.NewProduct()).then((value) {
              Helper.instance.checkInternet().then((intenet) {
                if(intenet) {
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
                      Text(DataSingleton.shared.productData == null || DataSingleton.shared.productData!.data!.isEmpty ? '0.00' : DataSingleton.shared.productData!.totalProfit.toString(),
                          style: TextStyle(
                              color: AppColors.success,
                              fontWeight: FontWeight.w100,
                              fontSize: 32)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 12),
                        child: const Text('Start Sales', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
                      ),
                      style: TextButton.styleFrom(
                        primary: AppColors.white,
                        backgroundColor: AppColors.label,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(21.0)),
                      ),
                      onPressed: () {
                        onPressed('startsales');
                      },
                    ),
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
                child: DataSingleton.shared.productData == null || DataSingleton.shared.productData!.data!.isEmpty ? Center(child: Text('Products Not Found', style: TextStyle(fontSize: 20.0)),) : ListView.builder(
                  primary: false,
                  itemCount: DataSingleton.shared.productData!.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: Card(
                        child: ListTile(
                          title: Text(DataSingleton.shared.productData!.data![index].name!, style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            children: [
                              Badge(
                                elevation: 0,
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: DataSingleton.shared.productData!.data![index].stockQty! <= 1 ? AppColors.error : (DataSingleton.shared.productData!.data![index].stockQty! >= 2 && DataSingleton.shared.productData!.data![index].stockQty! <= 7 ? AppColors.warning : AppColors.info ),
                                borderRadius: BorderRadius.circular(4),
                                badgeContent: Text(DataSingleton.shared.productData!.data![index].stockQty.toString(), style: TextStyle(color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.bold))
                              ),
                              SizedBox(width: 2.0,),
                              Badge(
                                elevation: 0,
                                toAnimate: false,
                                shape: BadgeShape.square,
                                badgeColor: DataSingleton.shared.productData!.data![index].isActive == 1 ? Colors.green : Colors.amber,
                                borderRadius: BorderRadius.circular(4),
                                badgeContent: DataSingleton.shared.productData!.data![index].isActive == 1 ? Text('active', style: TextStyle(color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.bold)) : Text('inactive', style: TextStyle(color: Colors.black, fontSize: 9.0, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          trailing: Text(DataSingleton.shared.productData!.data![index].currencySymbol!+' '+DataSingleton.shared.productData!.data![index].salesPrice!, style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold)),
                          onTap: () {
                            onTapClicked(DataSingleton.shared.productData!.data![index].id); 
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