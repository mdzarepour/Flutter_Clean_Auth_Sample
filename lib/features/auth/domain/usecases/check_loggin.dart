import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/features/auth/domain/repository/auth_repository.dart';

class CheckLoggin implements Usecase<bool, NoParams> {
  final AuthRepository authRepository;
  CheckLoggin({required this.authRepository});

  @override
  bool call({required NoParams params}) {
    return authRepository.checkLogin();
  }
}
