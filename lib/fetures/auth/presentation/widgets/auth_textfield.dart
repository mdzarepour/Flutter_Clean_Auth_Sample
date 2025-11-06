import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final String hint;
  final Widget icon;
  final bool? isObscure;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthTextfield({
    super.key,
    this.isObscure,
    this.onChanged,
    this.focusNode,
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
      focusNode: focusNode,
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
