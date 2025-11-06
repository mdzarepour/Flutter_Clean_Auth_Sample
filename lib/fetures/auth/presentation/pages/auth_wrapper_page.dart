import 'package:auth_sample/common/router/route_names.dart';
import 'package:auth_sample/core/utils/constants/const_colors.dart';
import 'package:auth_sample/core/utils/constants/const_strings.dart';
import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => (context).push(RouteNames.loginRoute),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ConstColors.firstBlue,
                          width: 2,
                        ),
                      ),
                      height: 60,
                      child: Center(
                        child: Text(
                          style: AppTextTheme.blue15semibold.copyWith(
                            fontSize: 20,
                          ),
                          'Login',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => (context).push(RouteNames.registerRoute),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ConstColors.firstBlue,
                          width: 2,
                        ),
                      ),
                      height: 60,
                      child: Center(
                        child: Text(
                          style: AppTextTheme.blue15semibold.copyWith(
                            fontSize: 20,
                          ),
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
}
