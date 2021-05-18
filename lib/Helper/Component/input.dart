import 'package:flutter/material.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final bool autocorrect;
  final int keyboardType;
  final int textInputAction;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = AppColors.border,
      this.controller, 
      this.autocorrect = false, 
      this.keyboardType,
      this.textInputAction
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: AppColors.muted,
        keyboardAppearance: Brightness.light,
        autocorrect: autocorrect,
        keyboardType: keyboardType == 00 ? TextInputType.text : (keyboardType == 01 ? TextInputType.number : TextInputType.numberWithOptions(decimal: true)),
        textInputAction: textInputAction == 00 ? TextInputAction.done : TextInputAction.next,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        style:
            TextStyle(height: 0.85, fontSize: 14.0, color: AppColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintStyle: TextStyle(
              color: AppColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
