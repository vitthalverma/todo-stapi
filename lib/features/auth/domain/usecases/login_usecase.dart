import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/respository/auth_repository.dart';

class LoginUsecase implements CoreUsecase<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await authRepository.login(params.identifier, params.password);
  }
}

class LoginParams {
  final String identifier;
  final String password;

  LoginParams({required this.identifier, required this.password});
}
