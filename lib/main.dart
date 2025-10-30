import 'package:auth_sample/core/theme/app_theme.dart';
import 'package:auth_sample/fetures/auth/presentation/cubit/auth_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_wrapper_page.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO manage login animation injection
//TODO save urls in better way
//TODO try to using go router
//TODO manage regexes in utils class and inject them

void main() {
  setupLocator();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: AuthWrapperPage(),
    );
  }
}
