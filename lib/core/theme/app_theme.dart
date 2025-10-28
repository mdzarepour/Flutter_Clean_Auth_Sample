import 'package:auth_sample/core/constants/const_colors.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ConstColors.firstWhite,
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: ConstColors.secondBlue,
      hintStyle: AppTextTheme.grey16normal,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: ConstColors.firstGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: ConstColors.firstBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: ConstColors.firstBlue),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: ConstColors.firstBlue),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: ConstColors.firstGrey),
      ),
    ),
  );
}
