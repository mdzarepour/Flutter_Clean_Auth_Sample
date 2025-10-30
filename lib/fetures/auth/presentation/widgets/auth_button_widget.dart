import 'package:auth_sample/core/constants/const_colors.dart';
import 'package:auth_sample/core/theme/app_text_theme.dart';
import 'package:auth_sample/fetures/auth/presentation/cubit/auth_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/widgets/auth_button_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const AuthButtonWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AuthButtonUi(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return _initialChild();
            }
            if (state is AuthLoading) {
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
