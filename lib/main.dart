import 'package:auth_sample/common/theme/app_theme.dart';
import 'package:auth_sample/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_sample/features/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//TODO wrte registerpage obscure toggle in single method

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ButtonCubit>(create: (context) => locator.get()),
        BlocProvider<AuthBloc>(create: (context) => locator.get()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: locator.get<GoRouter>(),
      ),
    );
  }
}
