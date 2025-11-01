import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthNavigatorLink extends StatelessWidget {
  final String message;
  final String title;
  final Widget screen;

  const AuthNavigatorLink({
    super.key,
    required this.message,
    required this.title,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final route = CupertinoPageRoute(builder: (context) => screen);
        Navigator.push(context, route);
      },
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
