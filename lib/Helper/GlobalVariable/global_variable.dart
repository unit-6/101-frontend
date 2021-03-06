import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalVariable {
  static final storage = new FlutterSecureStorage();

  static String? appVersion;
  static String? buildNumber;
  static String? udid;
  static String? platform;
  static String? osVersion;
  static String? phoneModel;
  static String? merchantID;
  static int? salesID;
  static int? salesStatus;

  Future deleteAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('first_run') ?? true) {
        await storage.deleteAll();
        prefs.setBool('first_run', false);
        debugPrint('Reset Flutter Secure Storage');
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
  
  Future addMerchantID(String keyString, String? valueString) async {
    await GlobalVariable.storage.write(key: keyString, value: valueString);
  }

  Future readMerchantID() async {
    String? keyMerchantID =  await GlobalVariable.storage.read(key: 'key_merchant_id');
    debugPrint('key_merchant_id : ' + keyMerchantID.toString());

    return keyMerchantID;
  }

  Future addSalesID(String keyString, String? valueString) async {
    await GlobalVariable.storage.write(key: keyString, value: valueString);
  }

  Future readSalesID() async {
    String? keySalesID =  await GlobalVariable.storage.read(key: 'key_sales_id');
    debugPrint('key_sales_id : ' + keySalesID.toString());

    return keySalesID;
  }

  Future addSalesStatus(String keyString, String? valueString) async {
    await GlobalVariable.storage.write(key: keyString, value: valueString);
  }

  Future readSalesStatus() async {
    String? keySalesStatus =  await GlobalVariable.storage.read(key: 'key_sales_status');
    debugPrint('key_sales_status : ' + keySalesStatus.toString());

    return keySalesStatus;
  }
}