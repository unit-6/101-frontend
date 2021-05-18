import 'package:flutter/material.dart';
import 'package:sbit_mobile/Helper/AppTheme/appColors.dart';

class AppThemeGlobal {
  static ThemeData appThemeGlobal = themeData();
  static ThemeData themeData(){
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      accentColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.bgColorScreen,

      // Define the default font family.
      fontFamily: 'montserrat',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText1: TextStyle(fontSize: 20.0),
        bodyText2: TextStyle(fontSize: 14.0),
      ),
    );
  }
}