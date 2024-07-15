part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String identifier;
  final String password;

  SignInEvent({required this.identifier, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignUpEvent(
      {required this.username, required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}
