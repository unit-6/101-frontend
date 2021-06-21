import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
import 'package:sbit_mobile/Helper/Component/navbar.dart';
import 'package:sbit_mobile/Helper/GlobalVariable/global_variable.dart';
import 'package:sbit_mobile/Helper/Provider/counter_bloc.dart';
// import 'package:sbit_mobile/Helper/Component/input.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Model/data_singleton.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;

ApiManager apiManager;
CounterBloc counterBloc;

bool isAddTrx, isEndSales;

class Sales extends StatefulWidget {

  @override
  _Sales createState() => _Sales();
}

class _Sales extends State<Sales> {
  
  //===================================== [START] API SERVICES ===================================================//

  Future onAddTrx(String qty, String currencyCode, String currencySymbol, String productId, String saleId) async {

    isAddTrx = true;
    isEndSales = false;

    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.addTrx(qty, currencyCode, currencySymbol, productId, saleId).then((res) {
      Navigator.of(context).pop();
      onReadResponse(true, res);
    }).catchError((res) {
      Navigator.of(context).pop();
      onReadResponse(false, res);
    });
  }

  Future onEndSales(String saleId) async {

    isAddTrx = false;
    isEndSales = true;

    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.endSales(saleId).then((res) {
      Navigator.of(context).pop();
      onReadResponse(true, res);
    }).catchError((res) {
      Navigator.of(context).pop();
      onReadResponse(false, res);
    });
  }
 
  

  //===================================== [END] API SERVICES ===================================================//
  
  void onReadResponse(bool status, res) {
    if(isAddTrx){
      if (status) {
        if (res['code'] == 200) {
          DialogHelper.customDialog(context, 'Success', res['message'], () { 
            ExtendedNavigator.ofRouter<ModuleRouter.Router>().popUntil(ModalRoute.withName(ModuleRouter.Routes.dashboard));
          });
        }
      }
    }

    if(isEndSales){
      if (status) {
        if (res['code'] == 200) {

          GlobalVariable().addSalesID('key_sales_id', null);
          GlobalVariable.salesID = null;

          GlobalVariable().addSalesStatus('key_sales_status', null);
          GlobalVariable.salesStatus = null;

          DialogHelper.customDialog(context, res['message'], 'Today profit: '+ res['profit'].toString(), () { 
            ExtendedNavigator.ofRouter<ModuleRouter.Router>().popUntil(ModalRoute.withName(ModuleRouter.Routes.dashboard));
          });
        }
      }
    }
  }

  void onPressed(String productName, int prodId) {
    counterBloc.reset();
    DialogHelper.quantityDialog(
      context,
        productName,
        '',
      () => { Navigator.of(context).pop() },
      () { 
          Navigator.of(context).pop();
          Helper.instance.checkInternet().then((intenet) {
          if(intenet != null && intenet) {
            onAddTrx(
              counterBloc.counter.toString(),
              'MYR',
              'RM',
              prodId.toString(),
              GlobalVariable.salesID.toString()
            );
          } else {
            DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
    counterBloc = Provider.of<CounterBloc>(context, listen: false);

    debugPrint('salesID: '+GlobalVariable.salesID.toString()+', salesStatus: '+GlobalVariable.salesStatus.toString());

    isAddTrx = false;
    isEndSales = false;

    // GlobalVariable().addSalesID('key_sales_id', null);
    // GlobalVariable.salesID = null;

    // GlobalVariable().addSalesStatus('key_sales_status', null);
    // GlobalVariable.salesStatus = null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: Navbar(
          title: 'Sales',
          noShadow: true,
          rightOptions: false,
          noButton: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(DataSingleton.shared.productData.data?.length?? 0, (index) {
                    return Container(
                      child: Card(
                        child: InkWell(
                          onTap: (){ 
                            onPressed(DataSingleton.shared.productData.data[index].name, DataSingleton.shared.productData.data[index].id);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: Text(
                                  DataSingleton.shared.productData.data[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  DataSingleton.shared.productData.data[index].currencySymbol+' '+DataSingleton.shared.productData.data[index].salesPrice,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: Text(
                                  'x'+DataSingleton.shared.productData.data[index].stockQty.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal)
                                ),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                        ),
                    );
                  }),  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    textColor: AppColors.white,
                    color: AppColors.initial,
                    onPressed: () {
                       DialogHelper.confirmDialog(
                        context,
                          'End Sales',
                          'Are you confirm to end today sales ?',
                        () => { Navigator.of(context).pop() },
                        () { 
                            Navigator.of(context).pop();
                            Helper.instance.checkInternet().then((intenet) {
                            if(intenet != null && intenet) {
                              onEndSales(
                                GlobalVariable.salesID.toString()
                              );
                            } else {
                              DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
                            }
                          });
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),),
                    child: Padding(
                      padding: EdgeInsets.only(top: 14, bottom: 14),
                      child: Text('End Sales', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0))
                    ),
                  ),
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