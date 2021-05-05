import 'package:flutter/material.dart';
import 'package:sbit_mobile/Helper/ShowDialog/custom_dialog.dart';
import 'package:sbit_mobile/Helper/ShowDialog/loading_dialog.dart';

class DialogHelper {
  static loadingDialog(context) => showDialog(context:context, barrierDismissible: false, builder: (context) => LoadingDialog());
  static customDialog(context, String title, String content, Function onPressed) => showDialog(context: context, barrierDismissible: false, builder: (context) => CustomDialog(titleMsg: title, contentMsg: content, onRetryPressed: onPressed));
}