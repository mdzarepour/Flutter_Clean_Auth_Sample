import 'package:auth_sample/fetures/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_sample/fetures/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImp({
    required this.authDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either> registerUser({required RegisterParams params}) async {
    try {
      final Response response = await authDatasource.registerUser(
        params: params,
      );

      final userId = response.data['id'];
      await authLocalDatasource.saveUserId(userId: userId);

      return right(response);
    } on DioException catch (e) {
      return left(e.response!.data['data']['username']['message']);
    }
  }

  @override
  Either<bool, bool> isUserLoggedIn() {
    final bool isUserLoggedIn = authLocalDatasource.isUserLoggedIn();
    if (isUserLoggedIn) {
      return right(true);
    } else {
      return left(false);
    }
  }
}
