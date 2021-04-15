import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/AppTheme/appTheme.dart';
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
            ],
            child: AppRootMain(),
          ),
        ),
      );
  });
}

class AppRootMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SBIT Mobile',
      initialRoute: ModuleRouter.Routes.approot,
      onGenerateRoute: ModuleRouter.Router().onGenerateRoute,
      builder: ExtendedNavigator<ModuleRouter.Router>(router: ModuleRouter.Router()),
      theme: AppThemeGlobal.appThemeGlobal,
    );
  }
}