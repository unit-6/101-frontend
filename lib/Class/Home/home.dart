import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
// import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';

ApiManager apiManager;
var listState;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
        appBar: AppBar(title: Text('Home')),
        body: SafeArea(
            child: Container(
              child: Text(listState.toString()),
            ),
          ),
      ),
      onWillPop: () async => true,
    );
  }
}