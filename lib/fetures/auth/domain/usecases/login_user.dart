import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/fetures/auth/data/models/login_params.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUser implements Usecase<Future<Either>, LoginParams> {
  final AuthRepository authRepository;
  LoginUser({required this.authRepository});

  @override
  Future<Either> call({required LoginParams params}) async {
    return await authRepository.loginUser(params: params);
  }
}
