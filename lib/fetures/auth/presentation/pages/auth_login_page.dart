import 'package:auth_sample/core/constants/const_strings.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/fetures/auth/presentation/animations/login_animation.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_button_widget.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final rabbit = LoginAnimation();

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;

  Future<void> _initRabbit() async {
    await rabbit.initAnimation();
    if (mounted) setState(() {});
  }

  void _toggleObscure() {
    setState(() => isObscure = !isObscure);
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
            : Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      _title(),
                      _animation(),
                      _passwordField(),
                      const SizedBox(height: 25),
                      _emailField(),
                      const SizedBox(height: 25),
                      _loginButton(),
                    ],
                  ),
                ),
              ),
      ),
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

  AuthTextfieldWidget _passwordField() {
    return AuthTextfieldWidget(
      controller: passwordController,
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
          rabbit.updateRabbitEye(open: isObscure, length: value.length);
        }
      },
      validator: (value) {},
    );
  }

  AuthTextfieldWidget _emailField() {
    return AuthTextfieldWidget(
      controller: emailController,
      hint: ConstStrings.email,
      icon: const Icon(CupertinoIcons.mail),
      onChanged: (value) {
        rabbit.updateRabbitEye(open: true, length: value.length);
      },
      validator: (value) {},
    );
  }

  AuthButtonWidget _loginButton() {
    return AuthButtonWidget(
      title: ConstStrings.login,
      onTap: () {
        if (formKey.currentState?.validate() ?? false) {
          rabbit.loginSuccess;
        } else {
          rabbit.loginFail;
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
