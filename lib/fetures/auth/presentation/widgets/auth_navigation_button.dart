import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/constants/const_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthNavigatioButton extends StatelessWidget {
  final String title;
  final Widget screen;
  const AuthNavigatioButton({
    super.key,
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
        child: Center(child: Text(style: AppTextTheme.white20bold, title)),
      ),
    );
  }
}
