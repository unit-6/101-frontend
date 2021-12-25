import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
import 'package:sbit_mobile/Helper/Component/input.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;

late ApiManager apiManager;

class EditProduct extends StatefulWidget {

  final String? vProdName;
  final String? vSalesPrice;
  final int? vStockQty;
  final int? vId;
  final int? vIsActive;
  final String? vCurrencyCode;
  final String? vCurrencySymbol;

  const EditProduct({Key? key, this.vProdName, this.vSalesPrice, this.vStockQty, this.vId, this.vIsActive, this.vCurrencyCode, this.vCurrencySymbol}) : super(key: key);

  @override
  _EditProduct createState() => _EditProduct();
}

class _EditProduct extends State<EditProduct> {

  final nameCtrl = TextEditingController();
  final salePriceCtrl = TextEditingController();
  final stockQtyCtrl = TextEditingController();

  //===================================== [START] API SERVICES ===================================================//
 
  Future onEditProduct(int? id, String name, String salesPrice, String? currencyCode, String? currencySymbol, String stockQty, int? isActive) async {
    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.editProduct(id, name, salesPrice, currencyCode, currencySymbol, stockQty, isActive).then((res) {
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
        // ExtendedNavigator.ofRouter<ModuleRouter.Router>().popUntil(ModalRoute.withName(ModuleRouter.Routes.dashboard));
        AutoRouter.of(context).popUntilRouteWithName(ModuleRouter.Dashboard.name);
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
      if(intenet) {
        onEditProduct(
          widget.vId,
          nameCtrl.text,
          salePriceCtrl.text,
          widget.vCurrencyCode,
          widget.vCurrencySymbol,
          stockQtyCtrl.text,
          widget.vIsActive
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

    nameCtrl.text = widget.vProdName!;
    salePriceCtrl.text = widget.vSalesPrice!;
    stockQtyCtrl.text = widget.vStockQty.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''), 
          backgroundColor: AppColors.bgColorScreen,  
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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
                              child: ElevatedButton(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                  child: const Text('Update', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
                                ),
                                style: TextButton.styleFrom(
                                  primary: AppColors.white,
                                  backgroundColor: AppColors.initial,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(4.0)),
                                ),
                                onPressed: () {
                                  onPressed();
                                },
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