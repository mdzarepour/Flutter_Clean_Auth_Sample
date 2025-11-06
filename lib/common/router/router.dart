import 'package:auth_sample/common/router/route_names.dart';
import 'package:auth_sample/common/router/router_stream.dart';
import 'package:auth_sample/common/widgets/cubit_button.dart';
import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_login_page.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_register_page.dart';
import 'package:auth_sample/fetures/auth/presentation/pages/auth_wrapper_page.dart';
import 'package:auth_sample/fetures/home/home_page.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthCubit authCubit;
  final SnackbarService snackbarService;
  AppRouter({required this.authCubit, required this.snackbarService});

  GoRouter get router => GoRouter(
    initialLocation: RouteNames.wrapperRouter,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    navigatorKey: snackbarService.navigatorKey,
    routes: [
      GoRoute(
        path: RouteNames.wrapperRouter,
        name: RouteNames.wrapperRouter,
        pageBuilder: (context, state) =>
            CupertinoPage(child: AuthWrapperPage()),
      ),
      GoRoute(
        path: RouteNames.loginRoute,
        name: RouteNames.loginRoute,
        pageBuilder: (context, state) => CupertinoPage(child: AuthLoginPage()),
      ),
      GoRoute(
        path: RouteNames.registerRoute,
        name: RouteNames.registerRoute,
        pageBuilder: (context, state) =>
            CupertinoPage(child: AuthRegisterPage()),
      ),
      GoRoute(
        path: RouteNames.homeRoute,
        name: RouteNames.homeRoute,
        pageBuilder: (context, state) => CupertinoPage(child: HomePage()),
      ),
    ],
    redirect: (context, state) {
      if (authCubit.state is Authenticated) {
        return RouteNames.homeRoute;
      }
      if (state.fullPath == RouteNames.wrapperRouter &&
          authCubit.state is NotAuthenticated) {
        return RouteNames.wrapperRouter;
      }
    },
  );
}
