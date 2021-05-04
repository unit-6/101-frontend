import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sbit_mobile/Helper/Webservice/app_exception.dart';

String baseUrl = 'https://sbit.dimensikini.xyz/';

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

  //===================================== END API ===================================================//
}