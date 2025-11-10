import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthNavButton extends StatelessWidget {
  final String title;
  final String route;
  const AuthNavButton({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => (context).push(route),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ConstColors.firstBlue, width: 2),
          ),
          height: 60,
          child: Center(
            child: Text(
              style: AppTextTheme.blue15semibold.copyWith(fontSize: 20),
              title,
            ),
          ),
        ),
      ),
    );
  }
}
