import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appTheme.dart';
import 'package:sbit_mobile/Helper/Provider/counter_bloc.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      Phoenix(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => ApiManager()),
              ChangeNotifierProvider(create: (_) => CounterBloc()),
            ],
            child: AppRootMain(),
          ),
        ),
      );
  });
}

class AppRootMain extends StatelessWidget {
  final _rootRouter = ModuleRouter.AppRouter();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SBIT Mobile',
      theme: AppThemeGlobal.appThemeGlobal,
      routerDelegate: _rootRouter.delegate(),  
      routeInformationParser: _rootRouter.defaultRouteParser(),
    );
  }
}