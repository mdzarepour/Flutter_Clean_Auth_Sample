part of 'button_cubit.dart';

@immutable
sealed class ButtonState {}

final class ButtonInitial extends ButtonState {}

final class ButtonLoading extends ButtonState {}

final class ButtonSuccess extends ButtonState {}

final class ButtonFail extends ButtonState {
  final String? errorMessage;
  ButtonFail({this.errorMessage});
}
