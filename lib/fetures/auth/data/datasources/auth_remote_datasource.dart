import 'package:auth_sample/core/netword/dio_client.dart';
import 'package:auth_sample/fetures/auth/data/models/login_model.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:dio/dio.dart';

abstract interface class AuthRemoteDatasource {
  Future<Response> registerUser({required RegisterParams params});
  Future<Response> loginUser({required LoginParams params});
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final DioClient dioClient;
  AuthRemoteDatasourceImp({required this.dioClient});

  @override
  Future<Response> registerUser({required RegisterParams params}) async {
    try {
      final Response response = await dioClient.post(
        'collections/users/records',
        data: params.toMap(),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Response> loginUser({required LoginParams params}) async {
    try {
      final Response response = await dioClient.post(
        'collections/users/auth-with-password',
        data: params.toMap(),
      );
      print('datasource yes');
      return response;
    } on DioException {
      rethrow;
    }
  }
}
