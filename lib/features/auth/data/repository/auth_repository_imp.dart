import 'package:auth_sample/core/netword/token_exeption.dart';
import 'package:auth_sample/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_sample/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_sample/features/auth/data/models/login_params.dart';
import 'package:auth_sample/features/auth/data/models/register_params.dart';
import 'package:auth_sample/features/auth/data/models/user_model.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/features/auth/domain/repository/auth_repository.dart';
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
        final UserModel userModel = UserModel.fromJson(map: response.data);
        final User user = userModel.toEntity();
        await authLocalDatasource.saveToken(token: user.token);
        return right(user);
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
  bool checkLogin() {
    final bool isUserLoggedIn = authLocalDatasource.checkLogin();
    if (isUserLoggedIn) {
      return true;
    } else {
      return false;
    }
  }
}
