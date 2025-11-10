import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/features/auth/domain/repository/auth_repository.dart';

class LogoutUser implements Usecase<Future<bool>, EmptyParams> {
  final AuthRepository authRepository;
  LogoutUser({required this.authRepository});

  @override
  Future<bool> call({required EmptyParams params}) async {
    return await authRepository.logoutUser();
  }
}
