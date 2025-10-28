import 'package:auth_sample/core/constants/const_colors.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const AuthButtonWidget({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: ConstColors.firstBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 20,
              color: ConstColors.firstBlue.withAlpha(60),
            ),
          ],
        ),
        child: Center(child: Text(style: AppTextTheme.white20bold, 'Login')),
      ),
    );
  }
}
