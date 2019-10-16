import 'package:auth_sample/core/theme/app_theme.dart';
import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_wrapper_page.dart';
import 'package:auth_sample/fetures/home/home_page.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO manage login animation injection
//TODO save urls in better way
//TODO try to using go router
//TODO manage regexes in utils class and inject them
//TODO fix push replacement after register success
//TODO learn how to user Empty params for methods
//TODO seperate username field from password
//TODO write navigator link navigations with gorouter
//TODO wrte registerpage obscure toggle in single method
//TODO manage snackbars in a contextless way

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
        BlocProvider<ToggleCubit>(create: (context) => locator.get()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        navigatorKey: locator.get<SnackbarService>().navigatorKey,
        home: BlocBuilder<ToggleCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return HomePage();
            }
            if (state is NotAuthenticated) {
              return AuthWrapperPage();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
