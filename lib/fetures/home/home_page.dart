import 'package:auth_sample/core/widgets/cubit_button.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/check_loggin.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_wrapper_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('please exit from app and retry')),
            );
          } else if (state is ButtonSuccess) {
            final route = CupertinoPageRoute(
              builder: (context) => AuthWrapperPage(),
            );
            Navigator.pushReplacement(context, route);
          }
        },
        child: Center(
          child: AuthCubitButton(
            title: 'Log Out',
            onTap: () {
              BlocProvider.of<ButtonCubit>(
                context,
              ).logout(params: EmptyParams());
            },
          ),
        ),
      ),
    );
  }
}
