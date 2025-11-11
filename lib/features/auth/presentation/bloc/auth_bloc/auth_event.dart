part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class ToggleAuthState extends AuthEvent {
  final NoParams emptyParams;
  ToggleAuthState({required this.emptyParams});
}
