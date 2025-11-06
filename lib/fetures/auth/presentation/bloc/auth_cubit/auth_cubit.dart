import 'package:auth_sample/fetures/auth/domain/usecases/check_loggin.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CheckLoggin checkLoggin;

  AuthCubit({required this.checkLoggin}) : super(AuthInitial());
  void toggleAuth(EmptyParams params) {
    final bool isAuthenticated = checkLoggin.call(params: params);
    if (isAuthenticated) {
      emit(Authenticated());
    } else {
      emit(NotAuthenticated());
    }
  }
}
