import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/GlobalVariable/global_variable.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
import 'package:sbit_mobile/Model/data_singleton.dart';
import 'package:sbit_mobile/Model/product.dart';

ApiManager apiManager;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final costCtrl = TextEditingController();

   var settingArr = [
      {
        'id': '0',
        'title':'Burger Daging',
        'subtitle': 'Stock Qty: 40',
        'price': 'RM 2.70'
      },
      {
        'id': '1',
        'title':'Burger Ayam',
        'subtitle': 'Stock Qty: 50',
        'price': 'RM 2.80'
      },
    ];

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

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
    onListProducts(GlobalVariable.merchantID);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                    color: Colors.pink,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.attach_money, size: 45),
                          title: Text('PROFIT', style: TextStyle(color: Colors.white, fontSize: 17.0),),
                          subtitle: Text('RM 0.00', style: TextStyle(color: Colors.white, fontSize: 25.0),),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('START SALES', style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                print('startsales clicked');
                              },
                            ),
                            FlatButton(
                              child: const Text('HISTORY', style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                print('history clicked');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    'List of Products',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                Container(padding: const EdgeInsets.symmetric(horizontal: 21.0), child: Divider(thickness: 1.0,)),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: DataSingleton.shared.productData == null || DataSingleton.shared.productData.data.isEmpty ? Center(child: Text('Products Not Found', style: TextStyle(fontSize: 20.0)),) : ListView.separated(
                      primary: false,
                      itemCount: DataSingleton.shared.productData.data?.length ?? 0,
                      itemBuilder:(context, index){
                        return ListTile(
                          title: Text(DataSingleton.shared.productData.data[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text('Stock Qty: '+DataSingleton.shared.productData.data[index].stockQty.toString()),
                          trailing: Text(DataSingleton.shared.productData.data[index].currencySymbol+' '+DataSingleton.shared.productData.data[index].salesPrice),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}