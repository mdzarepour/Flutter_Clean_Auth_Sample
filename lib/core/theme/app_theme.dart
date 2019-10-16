import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ConstColors.firstWhite,
    inputDecorationTheme: _textfieldTheme(),
  );

  static InputDecorationThemeData _textfieldTheme() {
    return InputDecorationThemeData(
      errorStyle: AppTextTheme.grey14normal,
      filled: true,
      fillColor: ConstColors.secondBlue,
      hintStyle: AppTextTheme.grey16normal,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: ConstColors.firstBlack),
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
    );
  }
}
