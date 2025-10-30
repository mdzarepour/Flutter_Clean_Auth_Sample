import 'package:auth_sample/core/constants/const_colors.dart';
import 'package:flutter/material.dart';

class AuthButtonUi extends StatelessWidget {
  final Widget child;
  const AuthButtonUi({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(child: child),
    );
  }
}
