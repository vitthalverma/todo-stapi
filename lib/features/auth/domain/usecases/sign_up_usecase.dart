import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/respository/auth_repository.dart';

class SignUpUsecase implements CoreUsecase<UserEntity, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await authRepository.signUp(
        params.username, params.email, params.password);
  }
}

class SignUpParams {
  final String username;
  final String email;
  final String password;

  SignUpParams(
      {required this.username, required this.email, required this.password});
}
