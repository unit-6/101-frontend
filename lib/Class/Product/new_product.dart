import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
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
        ExtendedNavigator.ofRouter<ModuleRouter.Router>().popUntil(ModalRoute.withName(ModuleRouter.Routes.home));
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
        appBar: AppBar(
          title: Text('Add New Product')
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
                          SizedBox(
                            height: 32.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: TextFormField(
                              controller: nameCtrl,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                  labelText: 'PRODUCT NAME',
                                  hintText: 'e.g. Burger Ayam, Burger Daging',
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 23.0, horizontal: 10.0),
                                  border: OutlineInputBorder(),
                                  counterText: ''),
                              onChanged: (value) => {},
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: TextFormField(
                              controller: salePriceCtrl,
                              autocorrect: false,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                  labelText: 'SALES PRICE (RM)',
                                  hintText: 'e.g. 2.70, 3.20',
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 23.0, horizontal: 10.0),
                                  border: OutlineInputBorder(),
                                  counterText: ''),
                              onChanged: (value) => {},
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: TextFormField(
                              controller: stockQtyCtrl,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                  labelText: 'STOCK QUANTITY',
                                  hintText: 'e.g. 30, 40',
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 23.0, horizontal: 10.0),
                                  border: OutlineInputBorder(),
                                  counterText: ''),
                              onChanged: (value) => {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80.0,
                    padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 16.0),
                    child: RaisedButton(
                      child: Text('Add', style: TextStyle(fontSize: 20.0)),
                      color: Colors.pink,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
                      onPressed: () {
                        onPressed();
                      }
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