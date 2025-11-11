import 'package:auth_sample/core/usecase/usecase.dart';
import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/features/auth/data/models/login_params.dart';
import 'package:auth_sample/features/auth/data/models/register_params.dart';
import 'package:auth_sample/features/auth/domain/entities/user.dart';
import 'package:auth_sample/features/auth/domain/usecases/login_user.dart';
import 'package:auth_sample/features/auth/domain/usecases/logout_user.dart';
import 'package:auth_sample/features/auth/domain/usecases/register_user.dart';
import 'package:auth_sample/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  final RegisterUser registerUserUsecase;
  final LoginUser loginUserUsecase;
  final LogoutUser logoutUserUsecase;
  final SnackbarService snackbarService;
  final AuthBloc authBloc;

  ButtonCubit({
    required this.registerUserUsecase,
    required this.loginUserUsecase,
    required this.logoutUserUsecase,
    required this.snackbarService,
    required this.authBloc,
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
      (user) {
        emit(ButtonSuccess(user: user));
        authBloc.add(ToggleAuthState(emptyParams: NoParams()));
        emit(ButtonInitial());
      },
    );
  }

  Future<void> logout({required NoParams params}) async {
    emit(ButtonLoading());
    final bool status = await logoutUserUsecase.call(params: params);
    if (status) {
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(ButtonSuccess());
      authBloc.add(ToggleAuthState(emptyParams: NoParams()));
      emit(ButtonInitial());
    } else {
      emit(ButtonFail());
      emit(ButtonInitial());
    }
  }
}
