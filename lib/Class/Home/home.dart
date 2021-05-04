import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
// import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';

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

  

  //===================================== [END] API SERVICES ===================================================//

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
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
                    child: ListView.separated(
                      primary: false,
                      itemCount: settingArr.length,
                      itemBuilder:(context, index){
                        return ListTile(
                          title: Text(settingArr[index]['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(settingArr[index]['subtitle']),
                          trailing: Text(settingArr[index]['price']),
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