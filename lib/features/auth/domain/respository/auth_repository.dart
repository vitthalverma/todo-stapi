import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String identifier, String password);
  Future<Either<Failure, UserEntity>> signUp(
    String username,
    String email,
    String password,
  );
  Future<Either<Failure, void>> logout();
}
