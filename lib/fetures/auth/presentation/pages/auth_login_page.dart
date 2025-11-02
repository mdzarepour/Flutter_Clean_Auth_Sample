// ignore_for_file: body_might_complete_normally_nullable

import 'package:auth_sample/core/utils/constants/const_strings.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/services/regex_service.dart';
import 'package:auth_sample/fetures/auth/data/models/login_model.dart';
import 'package:auth_sample/fetures/auth/presentation/animations/login_animation.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_register_page.dart';
import 'package:auth_sample/core/utils/widgets/cubit_button.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_navigator_link.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_textfield.dart';
import 'package:auth_sample/fetures/home/home_page.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;

  final formKey = GlobalKey<FormState>();
  final passwordFocusNode = FocusNode();

  final rabbit = locator.get<LoginAnimation>();
  final regex = locator.get<RegexService>();

  Future _initRabbit() async {
    await rabbit.initAnimation();
    if (mounted) setState(() {});
  }

  void _toggleObscure() {
    setState(() => isObscure = !isObscure);
    FocusScope.of(context).requestFocus(passwordFocusNode);
    rabbit.updateRabbitEye(
      open: !isObscure,
      length: passwordController.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        rabbit.resetRabbitState();
      },
      child: Scaffold(
        body: rabbit.artboard == null
            ? const Center(child: CircularProgressIndicator())
            : BlocListener<ButtonCubit, ButtonState>(
                listener: (context, state) {
                  if (state is ButtonFail) rabbit.fireFail();
                  if (state is ButtonSuccess) {
                    rabbit.fireSuccess();
                    Future.delayed(Duration(seconds: 2), () {
                      final route = CupertinoPageRoute(
                        builder: (context) => HomePage(),
                      );
                      Navigator.pushReplacement(context, route);
                    });
                  }
                },
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        _title(),
                        _animation(),
                        _usernameField(),
                        const SizedBox(height: 25),
                        _passwordField(),
                        const SizedBox(height: 25),
                        _loginButton(),
                        SizedBox(height: 20),
                        _navigatorLink(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  AuthNavigatorLink _navigatorLink() {
    return AuthNavigatorLink(
      message: 'Don\'t have account?',
      title: 'creata account',
      screen: AuthRegisterPage(),
    );
  }

  Text _title() {
    return Text(
      textAlign: TextAlign.center,
      ConstStrings.authLoginTitle,
      style: AppTextTheme.blue35bold,
    );
  }

  SizedBox _animation() {
    return SizedBox(
      height: 200,
      child: Rive(
        antialiasing: true,
        artboard: rabbit.artboard!,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _passwordField() {
    return AuthTextfield(
      controller: passwordController,
      focusNode: passwordFocusNode,
      isObscure: isObscure,
      hint: ConstStrings.password,
      icon: IconButton(
        onPressed: _toggleObscure,
        icon: Icon(isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          rabbit.resetRabbitState();
        } else {
          if (isObscure) {
            rabbit.updateRabbitEye(open: false, length: 0);
          } else {
            rabbit.updateRabbitEye(open: true, length: value.length);
          }
        }
      },
      validator: (value) {
        return regex.getMessage(regexType: RegexType.password, value: value);
      },
    );
  }

  Widget _usernameField() {
    return AuthTextfield(
      controller: usernameController,
      hint: ConstStrings.username,
      icon: const Icon(CupertinoIcons.person),
      onChanged: (value) {
        rabbit.updateRabbitEye(open: true, length: value.length);
      },
      validator: (value) {
        return regex.getMessage(regexType: RegexType.username, value: value);
      },
    );
  }

  AuthCubitButton _loginButton() {
    return AuthCubitButton(
      title: ConstStrings.login,
      onTap: () {
        if (formKey.currentState!.validate()) {
          BlocProvider.of<ButtonCubit>(context).login(
            params: LoginParams(
              identity: usernameController.text,
              password: passwordController.text,
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initRabbit();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
