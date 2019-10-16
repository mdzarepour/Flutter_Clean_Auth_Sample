import 'package:auth_sample/core/netword/dio_client.dart';
import 'package:auth_sample/fetures/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_sample/fetures/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_sample/fetures/auth/data/repository/auth_repository_imp.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/check_loggin.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/login_user.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/logout_user.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/register_user.dart';
import 'package:auth_sample/fetures/auth/presentation/animations/login_animation.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:auth_sample/fetures/auth/presentation/bloc/button_cubit/button_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // External dependencies -->
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // helper classes -->
  locator.registerLazySingleton<LoginAnimation>(() => LoginAnimation());

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
      registerUserUsecase: locator.get(),
      loginUserUsecase: locator.get(),
      logoutUserUsecase: locator.get(),
    ),
  );
  locator.registerFactory(
    () => ToggleCubit(checkLoggin: locator.get())..toggleAuth(EmptyParams()),
  );
}
