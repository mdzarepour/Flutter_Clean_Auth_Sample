import 'package:auth_sample/common/router/router.dart';
import 'package:auth_sample/core/netword/dio_client.dart';
import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/core/utils/services/regex_service.dart';
import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_sample/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_sample/features/auth/data/repository/auth_repository_imp.dart';
import 'package:auth_sample/features/auth/domain/repository/auth_repository.dart';
import 'package:auth_sample/features/auth/domain/usecases/check_loggin.dart';
import 'package:auth_sample/features/auth/domain/usecases/login_user.dart';
import 'package:auth_sample/features/auth/domain/usecases/logout_user.dart';
import 'package:auth_sample/features/auth/domain/usecases/register_user.dart';
import 'package:auth_sample/features/auth/presentation/animations/login_animation.dart';
import 'package:auth_sample/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_sample/features/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // External dependencies -->
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // helper classes -->
  locator.registerLazySingleton<LoginAnimation>(() => LoginAnimation());
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator.registerLazySingleton<RegexService>(() => RegexService());
  locator.registerLazySingleton<GoRouter>(
    () => AppRouter(
      snackbarService: locator.get(),
      authBloc: locator.get(),
    ).router,
  );

  // dio -->
  locator.registerSingleton<Dio>(Dio());
  locator.registerLazySingleton<DioClient>(() => DioClient());

  // datasources -->
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImp(dioClient: locator.get()),
  );
  locator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImp(sharedPreferences: locator.get()),
  );

  // repositories -->
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      authRemoteDatasource: locator.get(),
      authLocalDatasource: locator.get(),
    ),
  );

  // usecases -->
  locator.registerLazySingleton<RegisterUser>(
    () => RegisterUser(authRepository: locator.get()),
  );
  locator.registerLazySingleton<LogoutUser>(
    () => LogoutUser(authRepository: locator.get()),
  );

  locator.registerLazySingleton<LoginUser>(
    () => LoginUser(authRepository: locator.get()),
  );

  locator.registerLazySingleton<CheckLoggin>(
    () => CheckLoggin(authRepository: locator.get()),
  );

  // blocs & cubits -->
  locator.registerFactory(
    () => ButtonCubit(
      snackbarService: locator.get(),
      registerUserUsecase: locator.get(),
      loginUserUsecase: locator.get(),
      logoutUserUsecase: locator.get(),
    ),
  );

  locator.registerFactory(() {
    return AuthBloc(checkLoggin: locator.get())
      ..add(ToggleAuthState(emptyParams: NoParams()));
  });
}
