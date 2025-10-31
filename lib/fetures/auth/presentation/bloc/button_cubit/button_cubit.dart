import 'package:auth_sample/fetures/auth/domain/usecases/register_user.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  final RegisterUser registerUsecase;
  ButtonCubit({required this.registerUsecase}) : super(ButtonInitial());

  void execute({dynamic params}) async {
    emit(ButtonLoading());
    Either either = await registerUsecase.call(params: params);
    either.fold(
      (message) {
        emit(ButtonFail(errorMessage: message));
        emit(ButtonInitial());
      },
      (success) {
        emit(ButtonSuccess());
        emit(ButtonInitial());
      },
    );
  }
}
