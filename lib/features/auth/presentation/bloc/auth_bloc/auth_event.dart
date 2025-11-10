part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class ToggleAuthState extends AuthEvent {
  final EmptyParams emptyParams;
  ToggleAuthState({required this.emptyParams});
}
