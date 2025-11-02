import 'package:auth_sample/core/netword/sharedprefrences_exeption.dart';
import 'package:auth_sample/fetures/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_sample/fetures/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_sample/fetures/auth/data/models/login_model.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImp({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either> registerUser({required RegisterParams params}) async {
    try {
      final Response response = await authRemoteDatasource.registerUser(
        params: params,
      );
      if (response.statusCode == 200) {
        return right(response);
      } else {
        return left(response.data['data']['username']['message']);
      }
    } on DioException catch (e) {
      return left(e.response!.data['data']['username']['message']);
    }
  }

  @override
  Future<Either> loginUser({required LoginParams params}) async {
    try {
      final Response response = await authRemoteDatasource.loginUser(
        params: params,
      );
      if (response.statusCode == 200) {
        final String token = response.data['token'];
        await authLocalDatasource.saveToken(token: token);

        return right(response);
      } else {
        return left(response.data['message']);
      }
    } on DioException catch (e) {
      return left(e.response!.data['message']);
    }
  }

  @override
  Future<bool> logoutUser() async {
    try {
      await authLocalDatasource.removeToken();

      return true;
    } on TokenExeption {
      return false;
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
