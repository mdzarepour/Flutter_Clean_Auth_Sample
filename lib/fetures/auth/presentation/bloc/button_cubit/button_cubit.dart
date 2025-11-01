import 'package:auth_sample/fetures/auth/data/models/login_model.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/login_user.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/register_user.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  final RegisterUser registerUsecase;
  final LoginUser loginUsecase;

  ButtonCubit({required this.registerUsecase, required this.loginUsecase})
    : super(ButtonInitial());

  Future<void> register({required RegisterParams params}) async {
    emit(ButtonLoading());
    final either = await registerUsecase.call(params: params);
    either.fold(
      (message) {
        emit(ButtonFail(errorMessage: message));
        emit(ButtonInitial());
      },
      (id) {
        emit(ButtonSuccess());
        emit(ButtonInitial());
      },
    );
  }

  Future<void> login({required LoginParams params}) async {
    emit(ButtonLoading());
    final either = await loginUsecase.call(params: params);
    either.fold(
      (message) {
        emit(ButtonFail(errorMessage: message));
        emit(ButtonInitial());
      },
      (loginModel) {
        emit(ButtonSuccess());
        emit(ButtonInitial());
      },
    );
  }
}
