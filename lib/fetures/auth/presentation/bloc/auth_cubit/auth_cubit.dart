import 'package:auth_sample/fetures/auth/domain/usecases/check_loggin.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class ToggleCubit extends Cubit<AuthState> {
  final CheckLoggin checkLoggin;

  ToggleCubit({required this.checkLoggin}) : super(AuthInitial());
  void toggleAuth(EmptyParams params) {
    final bool isAuthenticated = checkLoggin.call(params: params);
    if (isAuthenticated) {
      emit(Authenticated());
    } else {
      emit(NotAuthenticated());
    }
  }
}
