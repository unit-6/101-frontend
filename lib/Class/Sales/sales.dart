// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/Component/navbar.dart';
import 'package:sbit_mobile/Helper/Provider/counter_bloc.dart';
// import 'package:sbit_mobile/Helper/Component/input.dart';
// import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';
import 'package:sbit_mobile/Model/data_singleton.dart';
import 'package:sbit_mobile/Helper/ShowDialog/dialog_helper.dart';
// import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;

ApiManager apiManager;
CounterBloc counterBloc;

class Sales extends StatefulWidget {

  @override
  _Sales createState() => _Sales();
}

class _Sales extends State<Sales> {
  
  //===================================== [START] API SERVICES ===================================================//
 
  

  //===================================== [END] API SERVICES ===================================================//
  
  void onReadResponse(bool status, res) {
   
  }

  void onPressed(String productName) {
    counterBloc.reset();
    DialogHelper.quantityDialog(
      context,
        productName,
        '',
      () => { Navigator.of(context).pop() },
      () { 

        
          debugPrint(counterBloc.counter.toString());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
    counterBloc = Provider.of<CounterBloc>(context, listen: false);
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
          child: Container(
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
                        onPressed(DataSingleton.shared.productData.data[index].name);
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
            )
          ),
        ),
      ),
      onWillPop: () async => true,
    );
  }
}