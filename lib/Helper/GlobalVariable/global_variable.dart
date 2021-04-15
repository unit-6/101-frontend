import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalVariable {
  static final storage = new FlutterSecureStorage();

  static String setAppVersion;
  static String setBuildNumber;

  static String appVersion() {
    return setAppVersion;
  }

  static String buildNumber(){
    return setBuildNumber;
  }
}