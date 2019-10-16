import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/fetures/auth/data/models/login_model.dart';
import 'package:auth_sample/fetures/auth/data/models/register_params.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/check_loggin.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/login_user.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/logout_user.dart';
import 'package:auth_sample/fetures/auth/domain/usecases/register_user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  final RegisterUser registerUserUsecase;
  final LoginUser loginUserUsecase;
  final LogoutUser logoutUserUsecase;
  final SnackbarService snackbarService;

  ButtonCubit({
    required this.registerUserUsecase,
    required this.loginUserUsecase,
    required this.logoutUserUsecase,
    required this.snackbarService,
  }) : super(ButtonInitial());

  Future<void> register({required RegisterParams params}) async {
    emit(ButtonLoading());
    final either = await registerUserUsecase.call(params: params);
    either.fold(
      (message) {
        emit(ButtonFail());
        snackbarService.showSnackbar(message: message);
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
    final either = await loginUserUsecase.call(params: params);
    either.fold(
      (message) {
        emit(ButtonFail());
        snackbarService.showSnackbar(message: message);
        emit(ButtonInitial());
      },
      (loginModel) {
        emit(ButtonSuccess());
        emit(ButtonInitial());
      },
    );
  }

  Future<void> logout({required EmptyParams params}) async {
    emit(ButtonLoading());
    final bool status = await logoutUserUsecase.call(params: params);
    if (status) {
      Future.delayed(Duration(milliseconds: 1500), () {
        emit(ButtonSuccess());
      });
    } else {
      emit(ButtonFail());
    }
  }
}
