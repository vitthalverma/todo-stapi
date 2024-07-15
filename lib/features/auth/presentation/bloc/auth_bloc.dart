import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc(
    this.loginUsecase,
    this.signUpUsecase,
    this.logoutUsecase,
  ) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUsecase(LoginParams(
        identifier: event.identifier,
        password: event.password,
      ));
      result.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthDone(r)),
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrUser = await signUpUsecase(SignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ));
      failureOrUser.fold(
        (failure) => emit(AuthFailure((failure.message))),
        (user) => emit(AuthDone(user)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await logoutUsecase(NoParams());
      result.fold(
        (failure) => emit(AuthFailure((failure.message))),
        (r) => emit(AuthInitial()),
      );
    });
  }
}
