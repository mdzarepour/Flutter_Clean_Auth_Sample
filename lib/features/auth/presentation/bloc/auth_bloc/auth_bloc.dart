import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/features/auth/domain/usecases/check_loggin.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckLoggin checkLoggin;

  AuthBloc({required this.checkLoggin}) : super(AuthInitial()) {
    on<ToggleAuthState>((event, emit) {
      final bool isAuthenticated = checkLoggin.call(params: event.emptyParams);
      print('$isAuthenticated === isauthenticated');
      if (isAuthenticated == true) {
        emit(Authenticated());
      }
      if (isAuthenticated == false) {
        emit(NotAuthenticated());
      }
    });
  }
}
