import 'package:flutter/material.dart';
import 'package:sbit_mobile/Helper/Component/input.dart';
import 'package:sbit_mobile/Helper/ShowDialog/confirm_dialog.dart';
import 'package:sbit_mobile/Helper/ShowDialog/custom_dialog.dart';
import 'package:sbit_mobile/Helper/ShowDialog/input_dialog.dart';
import 'package:sbit_mobile/Helper/ShowDialog/loading_dialog.dart';
import 'package:sbit_mobile/Helper/ShowDialog/quantity_dialog.dart';

class DialogHelper {
  static loadingDialog(context) => showDialog(context:context, barrierDismissible: false, builder: (context) => LoadingDialog());
  static customDialog(context, String? title, String? content, Function onPressed) => showDialog(context: context, barrierDismissible: false, builder: (context) => CustomDialog(titleMsg: title, contentMsg: content, onRetryPressed: onPressed));
  static inputDialog(context, String title, String content, Function onPressed1, Function onPressed, Input costField) => showDialog(context: context, barrierDismissible: false, builder: (context) => InputDialog(titleMsg: title, contentMsg: content, onRetryPressed1: onPressed1, onRetryPressed: onPressed, textField: costField,));
  static quantityDialog(context, String? title, String content, Function onPressed1, Function onPressed) => showDialog(context: context, barrierDismissible: false, builder: (context) => QuantityDialog(titleMsg: title, contentMsg: content, onRetryPressed1: onPressed1, onRetryPressed: onPressed,));
  static confirmDialog(context, String title, String content, Function onPressed1, Function onPressed) => showDialog(context: context, barrierDismissible: false, builder: (context) => ConfirmDialog(titleMsg: title, contentMsg: content, onRetryPressed1: onPressed1, onRetryPressed: onPressed,));
}