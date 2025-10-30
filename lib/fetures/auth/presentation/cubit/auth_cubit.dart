import 'package:auth_sample/fetures/auth/domain/usecases/register_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUsecase registerUsecase;
  AuthCubit({required this.registerUsecase}) : super(AuthInitial());

  void execute({dynamic params}) async {
    emit(AuthLoading());
    Either either = await registerUsecase.call(params: params);
    either.fold(
      (message) {
        emit(AuthFail(errorMessage: message));
        emit(AuthInitial());
      },
      (success) {
        emit(AuthSuccess());
      },
    );
  }
}
