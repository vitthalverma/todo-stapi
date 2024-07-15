part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthDone extends AuthState {
  final UserEntity user;

  AuthDone(this.user);
}
