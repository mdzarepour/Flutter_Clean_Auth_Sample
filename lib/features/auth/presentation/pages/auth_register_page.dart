import 'package:auth_sample/common/router/route_names.dart';
import 'package:auth_sample/common/widgets/cubit_button.dart';
import 'package:auth_sample/core/utils/constants/const_strings.dart';
import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/services/regex_service.dart';
import 'package:auth_sample/features/auth/data/models/register_params.dart';
import 'package:auth_sample/features/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/features/auth/presentation/widgets/auth_link_button.dart';
import 'package:auth_sample/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final regex = locator.get<RegexService>();
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
          if (state is ButtonSuccess) {
            context.pushReplacement(RouteNames.loginRoute);
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
                const SizedBox(height: 20),
                _navigatorLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navigatorLink() {
    return const AuthLinkButton(
      message: 'Already have an account?',
      title: 'Login',
      route: RouteNames.loginRoute,
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
        return regex.getMessage(regexType: RegexType.username, value: value);
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
        return regex.getMessage(regexType: RegexType.username, value: value);
      },
    );
  }

  Widget _passwordField() {
    return AuthTextfield(
      controller: passwordController,
      isObscure: isObscurePass,
      hint: ConstStrings.password,
      icon: IconButton(
        onPressed: () {},
        icon: Icon(
          isObscurePass ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
        ),
      ),
      validator: (value) {
        return regex.getMessage(regexType: RegexType.password, value: value);
      },
    );
  }

  Widget _passwordConfirmField() {
    return AuthTextfield(
      controller: passwordConfirmController,
      isObscure: isObscurePassConfirm,
      hint: ConstStrings.passwordConfirm,
      icon: IconButton(
        onPressed: () {},
        icon: Icon(
          isObscurePassConfirm ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
        ),
      ),
      validator: (value) {
        if (value != passwordController.text) {
          return ConstStrings.confirmPasswordMatchMsg;
        }
        return regex.getMessage(regexType: RegexType.password, value: value);
      },
    );
  }

  Widget _registerButton() {
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

  void toggleisObscure(bool isPassConfirm) {
    setState(() {
      if (isPassConfirm) {
        isObscurePassConfirm = !isObscurePassConfirm;
      }
      if (!isObscurePass) {
        isObscurePass = !isObscurePass;
      }
    });
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
