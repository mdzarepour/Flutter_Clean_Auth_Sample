import 'package:auth_sample/core/netword/dio_client.dart';
import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/fetures/auth/data/datasources/auth_datasource.dart';
import 'package:auth_sample/fetures/auth/data/repository/auth_repository_imp.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/register_usecase.dart';
import 'package:auth_sample/fetures/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // dio -->
  locator.registerSingleton<Dio>(Dio());
  locator.registerLazySingleton<DioClient>(() => DioClient());

  // datasources -->
  locator.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImp(dioClient: locator.get()),
  );

  //repositories -->
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(authDatasource: locator.get()),
  );

  //usecases -->
  locator.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(authRepository: locator.get()),
  );

  // blocs & cubits -->
  locator.registerFactory(() => AuthCubit(registerUsecase: locator.get()));
}
