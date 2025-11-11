import 'package:auth_sample/common/router/route_names.dart';
import 'package:auth_sample/common/router/router_stream.dart';
import 'package:auth_sample/common/widgets/app_exit_wrapper_.dart';
import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_sample/features/auth/presentation/pages/auth_login_page.dart';
import 'package:auth_sample/features/auth/presentation/pages/auth_register_page.dart';
import 'package:auth_sample/features/auth/presentation/pages/auth_wrapper_page.dart';
import 'package:auth_sample/features/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthBloc authBloc;
  final SnackbarService snackbarService;

  AppRouter({required this.authBloc, required this.snackbarService});

  GoRouter get router => GoRouter(
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    navigatorKey: snackbarService.navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: RouteNames.wrapperRouter,
    routes: [
      GoRoute(
        path: RouteNames.wrapperRouter,
        pageBuilder: (context, state) {
          return const CupertinoPage(
            child: AppExitWrapper(child: AuthWrapperPage()),
          );
        },
        redirect: (context, state) {
          final String previousRoute = state.extra as String? ?? 'null';

          if (authBloc.state is Authenticated) {
            if (previousRoute.contains(RouteNames.homeRoute)) {
              return RouteNames.wrapperRouter;
            } else {
              return RouteNames.homeRoute;
            }
          }
          if (authBloc.state is NotAuthenticated) {
            return RouteNames.wrapperRouter;
          }
          return null;
        },
      ),
      GoRoute(
        path: RouteNames.loginRoute,
        pageBuilder: (context, state) {
          return const CupertinoPage(
            child: AppExitWrapper(child: AuthLoginPage()),
          );
        },
      ),
      GoRoute(
        path: RouteNames.registerRoute,
        pageBuilder: (context, state) {
          return const CupertinoPage(
            child: AppExitWrapper(child: AuthRegisterPage()),
          );
        },
      ),
      GoRoute(
        path: RouteNames.homeRoute,
        pageBuilder: (context, state) {
          if (state.extra != null && state.extra is User) {
            final user = state.extra as User;
            return CupertinoPage(
              child: AppExitWrapper(child: HomePage(user: user)),
            );
          }
          return const CupertinoPage(child: AppExitWrapper(child: HomePage()));
        },
      ),
    ],
  );
}
