import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/fetures/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CheckLoggin implements Usecase<Either, EmptyParams> {
  final AuthRepository authRepository;
  CheckLoggin({required this.authRepository});

  @override
  Either call({required EmptyParams params}) {
    return authRepository.isUserLoggedIn();
  }
}

class EmptyParams {}
