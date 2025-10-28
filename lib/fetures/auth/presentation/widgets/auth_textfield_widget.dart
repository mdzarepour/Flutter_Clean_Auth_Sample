import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AuthTextfieldWidget extends StatelessWidget {
  final String hint;
  final Widget icon;
  final bool isObscure;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  const AuthTextfieldWidget({
    super.key,
    required this.hint,
    required this.icon,
    required this.isObscure,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      style: AppTextTheme.grey16normal,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintStyle: AppTextTheme.grey16normal,
        hintText: hint,
      ),
    );
  }
}
