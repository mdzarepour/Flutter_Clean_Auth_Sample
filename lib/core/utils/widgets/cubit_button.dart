import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/core/utils/constants/const_colors.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubitButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const AuthCubitButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: ConstColors.firstBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 20,
              color: ConstColors.firstBlue.withAlpha(60),
            ),
          ],
        ),
        child: BlocBuilder<ButtonCubit, ButtonState>(
          builder: (context, state) {
            if (state is ButtonInitial) {
              return _initialChild();
            }
            if (state is ButtonLoading) {
              return _loadinChild();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _loadinChild() {
    return Center(
      child: CircularProgressIndicator(color: ConstColors.firstWhite),
    );
  }

  Widget _initialChild() {
    return Center(child: Text(style: AppTextTheme.white20bold, title));
  }
}
