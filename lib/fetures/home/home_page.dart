import 'package:auth_sample/common/router/route_names.dart';
import 'package:auth_sample/common/widgets/cubit_button.dart';
import 'package:auth_sample/common/theme/app_text_theme.dart';
import 'package:auth_sample/fetures/auth/domain/entities/user.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/check_loggin.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_wrapper_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final User? user;
  const HomePage({super.key, this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccess) {
            context.pushReplacement(RouteNames.wrapperRouter);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                style: AppTextTheme.black20bold,
                user?.username ?? 'username',
              ),
              Text(style: AppTextTheme.black20bold, user?.name ?? 'name'),
              Text(style: AppTextTheme.black20bold, user?.id ?? 'id'),
              AuthCubitButton(
                title: 'Log Out',
                onTap: () {
                  BlocProvider.of<ButtonCubit>(
                    context,
                  ).logout(params: EmptyParams());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
