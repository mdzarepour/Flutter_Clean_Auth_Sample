import 'package:auth_sample/fetures/auth/data/datasources/auth_datasource.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImp({required this.authDatasource});

  @override
  Future<Either> registerUser({required RegisterParams params}) async {
    try {
      final Response response = await authDatasource.registerUser(
        params: params,
      );
      return right(response);
    } on DioException catch (e) {
      return left(e.response!.data['data']['username']['message']);
    }
  }
}
