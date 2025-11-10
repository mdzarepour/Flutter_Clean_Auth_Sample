import 'package:auth_sample/common/router/route_names.dart';
import 'package:auth_sample/core/utils/constants/const_strings.dart';
import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:auth_sample/features/auth/presentation/widgets/auth_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            SvgPicture.asset(height: 250, 'assets/wrapper_svg.svg'),
            const SizedBox(height: 45),
            Text(
              ConstStrings.authWrapperTitle,
              style: AppTextTheme.blue35bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              ConstStrings.authWrapperMessage,
              style: AppTextTheme.black15normal,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            const Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthNavButton(title: 'Login', route: RouteNames.loginRoute),
                AuthNavButton(
                  title: 'Register',
                  route: RouteNames.registerRoute,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
