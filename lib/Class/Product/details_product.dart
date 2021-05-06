import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';

ApiManager apiManager;

class DetailsProduct extends StatefulWidget {

  final int productId;

  const DetailsProduct({Key key, this.productId}) : super(key: key);

  @override
  _DetailsProduct createState() => _DetailsProduct();
}

class _DetailsProduct extends State<DetailsProduct> {

  //===================================== [START] API SERVICES ===================================================//

  Future onDetailsProduct(int id) async {
    Future.delayed(Duration.zero, () => DialogHelper.loadingDialog(context));
    await apiManager.detailsProduct(id).then((res) {
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
        
      }
    } else {
      // error status, enhance later
    }
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
    Helper.instance.checkInternet().then((intenet) {
      if(intenet != null && intenet) {
        onDetailsProduct(widget.productId);
      } else {
        DialogHelper.customDialog(context, 'No connection', 'Please check your network connection', () => { Phoenix.rebirth(context) });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Details')
        ),
        body: SafeArea(
          child: Container(
            
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}