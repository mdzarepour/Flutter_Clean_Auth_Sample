import 'package:auth_sample/core/constants/const_colors.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final String hint;
  final Widget icon;
  final bool? isObscure;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextfield({
    super.key,
    this.isObscure,
    this.onChanged,
    required this.validator,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure ?? false,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      style: AppTextTheme.grey16normal,
      decoration: InputDecoration(
        suffixIconColor: ConstColors.firstGrey,
        suffixIcon: icon,
        hintStyle: AppTextTheme.grey16normal,
        hintText: hint,
      ),
    );
  }
}
