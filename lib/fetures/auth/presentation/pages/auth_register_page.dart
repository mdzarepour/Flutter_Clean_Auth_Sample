// ignore_for_file: body_might_complete_normally_nullable

import 'package:auth_sample/core/constants/const_regexes.dart';
import 'package:auth_sample/core/constants/const_strings.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/presentation/cubit/auth_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_button_widget.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_textfield_widget.dart';
import 'package:auth_sample/fetures/home/home_page.dart';
import 'package:auth_sample/locator.dart';
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
      body: BlocProvider<AuthCubit>(
        create: (context) => locator.get(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFail) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is AuthSuccess) {
              final route = CupertinoPageRoute(
                builder: (context) => HomePage(),
              );
              Navigator.of(context).pushReplacement(route);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _title() {
    return Text(
      textAlign: TextAlign.center,
      ConstStrings.authRegisterTitle,
      style: AppTextTheme.blue35bold,
    );
  }

  AuthTextfieldWidget _usernameField() {
    return AuthTextfieldWidget(
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

  AuthTextfieldWidget _nameField() {
    return AuthTextfieldWidget(
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

  AuthTextfieldWidget _passwordField() {
    return AuthTextfieldWidget(
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

  AuthTextfieldWidget _passwordConfirmField() {
    return AuthTextfieldWidget(
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
          isObscurePass ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
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

  AuthButtonWidget _registerButton() {
    return AuthButtonWidget(
      title: ConstStrings.register,
      onTap: () async {
        if (formKey.currentState!.validate()) {
          BlocProvider.of<AuthCubit>(context).execute(
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
