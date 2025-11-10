import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthLinkButton extends StatelessWidget {
  final String message;
  final String title;
  final String route;

  const AuthLinkButton({
    super.key,
    required this.message,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(route),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(style: AppTextTheme.black15semibold, message),
          Text(style: AppTextTheme.blue15semibold, title),
        ],
      ),
    );
  }
}
