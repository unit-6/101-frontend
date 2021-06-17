import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:provider/provider.dart';
import 'package:sbit_mobile/Helper/GlobalVariable/global_variable.dart';
import 'package:sbit_mobile/Helper/Helper/helper.dart';
import 'package:sbit_mobile/Helper/Routes/router.gr.dart' as ModuleRouter;
import 'package:sbit_mobile/Helper/Webservice/api_manager.dart';

ApiManager apiManager;

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //===================================== [START] API SERVICES ===================================================//
  Future onMerchantRegister(String udid, String phoneModel, String osVersion, String platform, String appVersion) async {
    await apiManager.merchantRegister(udid, phoneModel, osVersion, platform, appVersion).then((res) {
      onReadResponse(true, res);
    }).catchError((res) {
      onReadResponse(false, res);
    });
  }
  //===================================== [END] API SERVICES ===================================================//

  void onReadResponse(bool status, res) {
    if (status) {
      if (res['code'] == 200) {
        GlobalVariable().addMerchantID('key_merchant_id', res['merchant_id']);
        GlobalVariable.merchantID = res['merchant_id'];
      }
    } else {
      // error status, enhance later
    }
  }

  @override
  void initState() {
    super.initState();
    apiManager = Provider.of<ApiManager>(context, listen: false);
    
    Future.delayed(Duration(seconds: 3), () {
      checkLoginStatus();
    });
    checkAppInfo();
  }

  Future checkLoginStatus() async {
    // final storage = FlutterSecureStorage();
    // String loggedIn = await storage.read(key: "loginstatus");
    // if (loggedIn == null || loggedIn == "loggedout") {
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    // } else {
    //   if (loggedIn == "loggedin") {
    //     Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //             builder: (BuildContext context) =>
    //                 InitializeProviderDataScreen()));
    //   }
    // }

    // GlobalVariable().removeTerminalSecret();
    // GlobalVariable().removePassCode();

    ExtendedNavigator.ofRouter<ModuleRouter.Router>().pushReplacementNamed(ModuleRouter.Routes.dashboard);
  }

  void checkAppInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceData, osVersion, platform;

    PackageInfo packageInfo;
    String udid;

    try {
      udid = await FlutterUdid.udid;
      packageInfo = await PackageInfo.fromPlatform();

      GlobalVariable.udid = udid;
      GlobalVariable.appVersion = packageInfo.version;
      GlobalVariable.buildNumber = packageInfo.buildNumber;
      GlobalVariable().deleteAll();

      if (Platform.isAndroid) {
        debugPrint('Android Platform');

        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceData = androidInfo.model;
        osVersion = androidInfo.version.release;
        platform = 'Android';

        GlobalVariable.platform = 'Android';
        GlobalVariable.phoneModel = deviceData;
        GlobalVariable.osVersion = osVersion;
      }

      if (Platform.isIOS) {
        debugPrint('iOS Platform');

        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceData = Helper.instance.iOSDeviceName(iosInfo.utsname.machine);
        osVersion = iosInfo.systemVersion;
        platform = 'iOS';

        GlobalVariable.platform = 'iOS';
        GlobalVariable.phoneModel = deviceData;
        GlobalVariable.osVersion = osVersion;
      }
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    debugPrint('UDID: ' + udid);
    debugPrint('APP VERSION: ' + packageInfo.version);
    debugPrint('BUILD NUMBER: ' + packageInfo.buildNumber);
    debugPrint('PHONE MODEL: ' + deviceData);
    debugPrint('OS VERSION: ' + osVersion);

    GlobalVariable().readMerchantID().then((value) {
      if (value != null) {
        GlobalVariable.merchantID = value;
      } else {
        onMerchantRegister(udid, deviceData, osVersion, platform, packageInfo.version);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff8d168b), Color(0xfff1c241)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 130,
            height: 130,
            color: Colors.transparent,
            child: Image.asset(
              'assets/images/sbit-04.png',
            ),
          ),
        ),
      ),
    );
  }
}