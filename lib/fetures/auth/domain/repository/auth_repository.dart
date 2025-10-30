import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either> registerUser({required RegisterParams params});
}
