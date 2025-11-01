import 'package:auth_sample/fetures/auth/data/models/login_model.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either> registerUser({required RegisterParams params});
  Future<Either> loginUser({required LoginParams params});
  Either<bool, bool> isUserLoggedIn();
}
