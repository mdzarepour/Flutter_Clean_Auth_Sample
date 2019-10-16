// ignore_for_file: body_might_complete_normally_nullable

import 'package:auth_sample/core/constants/const_regexes.dart';
import 'package:auth_sample/core/constants/const_strings.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_login_page.dart';
import 'package:auth_sample/core/widgets/cubit_button.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_navigator_link.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isObscurePass = true;
  bool isObscurePassConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonFail) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state is ButtonSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => const AuthLoginPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 50),
                _title(),
                const SizedBox(height: 30),
                _usernameField(),
                const SizedBox(height: 25),
                _nameField(),
                const SizedBox(height: 25),
                _passwordField(),
                const SizedBox(height: 25),
                _passwordConfirmField(),
                const SizedBox(height: 25),
                _registerButton(),
                SizedBox(height: 20),
                _navigatorLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AuthNavigatorLink _navigatorLink() {
    return AuthNavigatorLink(
      message: 'Already have an account?',
      title: 'Login',
      screen: AuthLoginPage(),
    );
  }

  Text _title() {
    return Text(
      textAlign: TextAlign.center,
      ConstStrings.authRegisterTitle,
      style: AppTextTheme.blue35bold,
    );
  }

  Widget _usernameField() {
    return AuthTextfield(
      hint: ConstStrings.username,
      icon: const Icon(CupertinoIcons.person),
      controller: usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ConstStrings.usernameEmptyMsg;
        }
        if (!ConstRegexes.usernamePattern.hasMatch(value)) {
          return ConstStrings.usernameMatchMsg;
        }
      },
    );
  }

  Widget _nameField() {
    return AuthTextfield(
      isObscure: false,
      controller: nameController,
      hint: ConstStrings.name,
      icon: const Icon(CupertinoIcons.person),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ConstStrings.usernameEmptyMsg;
        }
        if (!ConstRegexes.usernamePattern.hasMatch(value)) {
          return ConstStrings.usernameMatchMsg;
        }
      },
    );
  }

  Widget _passwordField() {
    return AuthTextfield(
      controller: passwordController,
      isObscure: isObscurePass,
      hint: ConstStrings.password,
      icon: IconButton(
        onPressed: () {
          setState(() {
            isObscurePass = !isObscurePass;
          });
        },
        icon: Icon(
          isObscurePass ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ConstStrings.passwordEmptyMsg;
        }
        if (!ConstRegexes.passwordPattern.hasMatch(value)) {
          return ConstStrings.passwordMatchMsg;
        }
      },
    );
  }

  Widget _passwordConfirmField() {
    return AuthTextfield(
      controller: passwordConfirmController,
      isObscure: isObscurePassConfirm,
      hint: ConstStrings.passwordConfirm,
      icon: IconButton(
        onPressed: () {
          setState(() {
            isObscurePassConfirm = !isObscurePassConfirm;
          });
        },
        icon: Icon(
          isObscurePassConfirm ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ConstStrings.confirmPasswordEmptyMsg;
        }
        if (value != passwordController.text) {
          return ConstStrings.confirmPasswordMatchMsg;
        }
      },
    );
  }

  AuthCubitButton _registerButton() {
    return AuthCubitButton(
      title: ConstStrings.register,
      onTap: () {
        if (formKey.currentState!.validate()) {
          BlocProvider.of<ButtonCubit>(context).register(
            params: RegisterParams(
              username: usernameController.text,
              name: nameController.text,
              password: passwordController.text,
              passwordConfirm: passwordConfirmController.text,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }
}
