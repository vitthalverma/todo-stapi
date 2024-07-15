import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/auth/domain/respository/auth_repository.dart';

class LogoutUsecase implements CoreUsecase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
