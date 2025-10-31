import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUser implements Usecase<Future<Either>, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUser({required this.authRepository});

  @override
  Future<Either> call({required RegisterParams params}) async {
    return await authRepository.registerUser(params: params);
  }
}
