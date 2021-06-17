import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sbit_mobile/Helper/Webservice/app_exception.dart';

String baseUrl = 'https://sbit.dimensikini.xyz';

class ApiManager extends ChangeNotifier {

  //===== [START] GET REQUEST FUNCTION =====//
  Future<http.Response> getRequest(String url) async {
    http.Response response;
    Map<String, String> headers = new HashMap();
    headers.putIfAbsent('Accept', () => 'application/json');

    try {
      response = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(const Duration(seconds: 60));
    } on TimeoutException catch (e) {
      debugPrint('Timeout $e');
    } on Error catch (e) {
      debugPrint('Error: $e');
    } on SocketException {
      return null;
    }

    var bodyObj = json.decode(response.body);
    var bodyStr = JsonEncoder.withIndent('  ').convert(bodyObj);

    debugPrint('urlString $url');
    debugPrint('statusCode ${response.statusCode}');
    debugPrint('returnMsg $bodyStr');

    return response;
  }
  //===== [END] GET REQUEST FUNCTION =====//

  //===== [START] POST REQUEST FUNCTION =====//
  Future<http.Response> postRequest(dynamic url, dynamic body,
      {String contentType}) async {
    http.Response response;
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] =
        contentType != null ? contentType : 'application/json';
    headers['Data-Type'] = 'json';
    headers['Cache-Control'] = 'no-cache, no-store, must-revalidate';

    try {
      response = await http
          .post(
            url,
            headers: headers,
            body: body,
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: 60));
    } on TimeoutException catch (e) {
      debugPrint('Timeout $e');
    } on Error catch (e) {
      debugPrint('Error: $e');
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      return throw Exception(e.toString());
    }

    try {
      debugPrint('urlString $url');
      var headerObj = json.encode(headers);
      debugPrint('requestHdr $headerObj');
      var bodyReq = JsonEncoder.withIndent('  ').convert(body);
      debugPrint('requestMsg $bodyReq');
      debugPrint('statusCode ${response.statusCode}');
      var bodyObj = json.decode(response.body);
      var bodyStr = JsonEncoder.withIndent('  ').convert(bodyObj);
      debugPrint('returnMsg $bodyStr');
    } on Exception catch (e) {
      debugPrint('$e');
    }

    return response;
  }
  //===== [END] POST REQUEST FUNCTION =======//
  
  //===== [START] RETURNED RESPONSE =====//
  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        try {
          return jsonDecode(response.body.toString());
        } on Exception {
          return response.body.toString();
        }
        break;
      case 201:
        try {
          return jsonDecode(response.body.toString());
        } on Exception {
          return response.body.toString();
        }
        break;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw ResourcesNotFound(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
  //===== [END] RETURNED RESPONSE =====//

  //===================================== START API =================================================//
  
  Future merchantRegister(String udid, String phoneModel, String osVersion, String platform, String appVersion) async {
    String urlString = baseUrl + '/api/merchant/register';
    var returnMsg;

    Map<String, dynamic> body = {
      'udid': udid,
      'phoneModel': phoneModel,
      'osVersion': osVersion,
      'platform': platform,
      'appVersion': appVersion
    };

    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future listProducts(String mid) async {
    String urlString = baseUrl + '/api/merchant/listProduct';
    var returnMsg;

    Map<String, dynamic> body = {
      'merchant_id': mid
    };

    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future addProduct(String name, String salesPrice, String currencyCode, String currencySymbol, String stockQty, String mid) async {
    String urlString = baseUrl + '/api/merchant/addProduct';
    var returnMsg;

    Map<String, dynamic> body = {
      'name': name,
      'salesPrice': salesPrice,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'stockQty': stockQty,
      'merchant_id': mid
    };

    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future detailsProduct(int productId) async {
    String urlString = baseUrl + '/api/merchant/detailsProduct';
    var returnMsg;

    Map<String, dynamic> body = {
      'id': productId.toString()
    };

    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future editProduct(int id, String name, String salesPrice, String currencyCode, String currencySymbol, String stockQty, int isActive) async {
    String urlString = baseUrl + '/api/merchant/editProduct';
    var returnMsg;

    Map<String, dynamic> body = {
      'id': id,
      'name': name,
      'salesPrice': salesPrice,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'stockQty': stockQty,
      'isActive': isActive
    };

    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future startSales(String cost, String currencyCode, String currencySymbol, String mid) async {
    String urlString = baseUrl + '/api/merchant/startSales';
    var returnMsg;

    Map<String, dynamic> body = {
      'cost': cost,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'merchant_id': mid
    };
    
    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future addTrx(String qty, String currencyCode, String currencySymbol, String productId, String saleId) async {
    String urlString = baseUrl + '/api/merchant/addTrx';
    var returnMsg;

    Map<String, dynamic> body = {
      'qty': qty,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'product_id': productId,
      'sale_id': saleId
    };
    
    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  Future endSales(String saleId) async {
    String urlString = baseUrl + '/api/merchant/endSales';
    var returnMsg;

    Map<String, dynamic> body = {
      'sale_id': saleId
    };
    
    await postRequest(urlString, json.encode(body)).then((res) {
      returnMsg = returnResponse(res);
    });
    return returnMsg;
  }

  //===================================== END API ===================================================//
}