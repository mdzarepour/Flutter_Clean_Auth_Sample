import 'package:auth_sample/core/netword/dio_client.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:dio/dio.dart';

abstract interface class AuthDatasource {
  Future<Response> registerUser({required RegisterParams params});
}

class AuthDatasourceImp implements AuthDatasource {
  final DioClient dioClient;
  AuthDatasourceImp({required this.dioClient});

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
}
