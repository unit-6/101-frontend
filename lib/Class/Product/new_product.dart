import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
import 'package:sbit_mobile/Helper/Component/input.dart';
import 'package:sbit_mobile/Helper/Component/navbar.dart';
import 'package:sbit_mobile/Helper/GlobalVariable/global_variable.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;

ApiManager apiManager;

class NewProduct extends StatefulWidget {

  @override
  _NewProduct createState() => _NewProduct();
}

class _NewProduct extends State<NewProduct> {

  final nameCtrl = TextEditingController();
  final salePriceCtrl = TextEditingController();
  final stockQtyCtrl = TextEditingController();

  //===================================== [START] API SERVICES ===================================================//
 
  Future onAddProduct(String name, String salesPrice, String currencyCode, String currencySymbol, String stockQty, String mid) async {
    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.addProduct(name, salesPrice, currencyCode, currencySymbol, stockQty, mid).then((res) {
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
        DialogHelper.customDialog(context, 'Success', res['message'], () { 
        ExtendedNavigator.ofRouter<ModuleRouter.Router>().popUntil(ModalRoute.withName(ModuleRouter.Routes.dashboard));
      });
      }
    } else {
      // error status, enhance later
    }
  }

  void onPressed() {
    if(nameCtrl.text.isNotEmpty && salePriceCtrl.text.isNotEmpty && stockQtyCtrl.text.isNotEmpty) {
      debugPrint('name=${nameCtrl.text} : salesPrice=${salePriceCtrl.text} : stockQty=${stockQtyCtrl.text}');
      Helper.instance.checkInternet().then((intenet) {
      if(intenet != null && intenet) {
        onAddProduct(
          nameCtrl.text,
          salePriceCtrl.text,
          'MYR',
          'RM',
          stockQtyCtrl.text,
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
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      
      child: Scaffold(
        appBar: Navbar(
          title: 'New Product',
          noShadow: true,
          rightOptions: false,
          backButton: true
        ),
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, top: 32),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Product name',
                                  style: TextStyle(
                                      color: AppColors.text,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Input(
                              placeholder: 'e.g. Burger Ayam, Burger Daging',
                              controller: nameCtrl,
                              keyboardType: 00,
                              textInputAction: 01,
                              onChanged: (value) => {},
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, top: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Sales Price (RM)',
                                  style: TextStyle(
                                      color: AppColors.text,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Input(
                              placeholder: 'e.g. 2.70, 3.20',
                              controller: salePriceCtrl,
                              keyboardType: 03,
                              textInputAction: 01,
                              onChanged: (value) => {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, top: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Stock Quantity',
                                  style: TextStyle(
                                      color: AppColors.text,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Input(
                              placeholder: 'e.g. 30, 40',
                              controller: stockQtyCtrl,
                              keyboardType: 01,
                              textInputAction: 00,
                              onChanged: (value) => {},
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: RaisedButton(
                                textColor: AppColors.white,
                                color: AppColors.initial,
                                onPressed: () {
                                  onPressed();
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                  child: Text('Add New', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0))
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}