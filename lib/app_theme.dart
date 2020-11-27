import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF823636);
  static const Color secondaryColor = Color(0xFF368282);
  static const Color bgColor = Color(0xFFFBFBFB);
  static const Color primaryTextColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFFFFFFFF);

  static const Color errorTextColor = Color(0xFF990000);
  static const Color errorTextBgColor = Color(0xFFFF9900);
  static const Color successTextColor = Color(0xFF009900);
  static const Color successTextBgColor = Color(0xFFCCFF66);
  static final ThemeData theme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _textTheme,
    // Define the default font family.
    fontFamily: 'OpenSans',
  );

  static final TextTheme _textTheme = TextTheme(
    button: _buttonTextStyle,
  );
  static final TextStyle _buttonTextStyle =
      TextStyle(fontSize: 16.0, letterSpacing: 1.2, color: secondaryTextColor);

  static final TextStyle secondaryTextStyle =
      TextStyle(fontSize: 10.0, letterSpacing: 1.2, color: secondaryTextColor);
  static final TextStyle errorTextStyle = TextStyle(
      fontSize: 16.0,
      letterSpacing: 1.2,
      color: errorTextColor,
      backgroundColor: errorTextBgColor);
  static final TextStyle successTextStyle = TextStyle(
      fontSize: 16.0,
      letterSpacing: 1.2,
      color: successTextColor,
      backgroundColor: successTextBgColor);
}
