import 'package:auth_sample/core/constants/const_strings.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_login_page.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_navigation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'auth_register_page.dart';

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
            SizedBox(height: 45),
            SvgPicture.asset(height: 250, 'assets/wrapper_svg.svg'),
            SizedBox(height: 45),
            Text(
              ConstStrings.authWrapperTitle,
              style: AppTextTheme.blue35bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              ConstStrings.authWrapperMessage,
              style: AppTextTheme.black15normal,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AuthNavigatioButton(
                    title: ConstStrings.login,
                    screen: AuthLoginPage(),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _navigate(context, AuthRegisterPage()),
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          style: AppTextTheme.black20bold,
                          'Register',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) async {
    final route = CupertinoPageRoute(builder: (_) => screen);
    Navigator.push(context, route);
  }
}
