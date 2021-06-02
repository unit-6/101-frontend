import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';
import 'package:sbit_mobile/Helper/Component/navbar.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';

ApiManager apiManager;
String productName = '';
String salesPrice = '';
int stockQty = 0;
int isActive = 0;
String createdAt = '';

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
        setState(() {
          productName = res['data']['name'];
          salesPrice = res['data']['currencySymbol']+' '+res['data']['salesPrice'];
          stockQty = res['data']['stockQty'];
          isActive = res['data']['isActive'];
          createdAt = res['data']['created_at'];
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
        appBar: Navbar(
          title: 'Product Details',
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
                          padding: const EdgeInsets.only(left: 4.0, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(productName,
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 32),
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
                          padding: const EdgeInsets.only(left: 4.0, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(salesPrice,
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 32),
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
                          padding: const EdgeInsets.only(left: 4.0, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(stockQty.toString(),
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 32),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Status',
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Badge(
                                  elevation: 0,
                                  toAnimate: false,
                                  shape: BadgeShape.square,
                                  badgeColor: isActive == 1 ? Colors.green : Colors.amber,
                                  borderRadius: BorderRadius.circular(4),
                                  badgeContent: isActive == 1 ? Text('active', style: TextStyle(color: AppColors.text, fontSize: 15.0, fontWeight: FontWeight.bold)) : Text('inactive', style: TextStyle(color: AppColors.text, fontSize: 15.0, fontWeight: FontWeight.bold)),
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 32),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Created At',
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(createdAt,
                                style: TextStyle(
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15)),
                          ),
                        ),
                      ],
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