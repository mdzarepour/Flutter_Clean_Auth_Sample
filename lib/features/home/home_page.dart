import 'package:auth_sample/common/widgets/cubit_button.dart';
import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/features/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/common/router/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User? user;
  const HomePage({super.key, this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccess) {
            context.go(RouteNames.wrapperRouter, extra: RouteNames.homeRoute);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: user == null
              ? Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('user not saved locally please log in again'),
                    AuthCubitButton(
                      title: 'Log Out',
                      onTap: () {
                        BlocProvider.of<ButtonCubit>(
                          context,
                        ).logout(params: NoParams());
                      },
                    ),
                  ],
                )
              : Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user!.username),
                    AuthCubitButton(
                      title: 'Log Out',
                      onTap: () {
                        BlocProvider.of<ButtonCubit>(
                          context,
                        ).logout(params: NoParams());
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
