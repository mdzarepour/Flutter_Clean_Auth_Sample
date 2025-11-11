import 'package:auth_sample/features/auth/data/models/login_params.dart';
import 'package:auth_sample/features/auth/data/models/register_params.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either> registerUser({required RegisterParams params});
  Future<Either> loginUser({required LoginParams params});
  bool checkLogin();
  Future<bool> logoutUser();
}
