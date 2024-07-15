import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/error/exceptions.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/features/auth/data/auth_remote_data/auth_remote_data_source.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/respository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> login(
      String identifier, String password) async {
    try {
      final user = await authRemoteDataSource.login(identifier, password);
      return right(user);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
      String username, String email, String password) async {
    try {
      final user = await authRemoteDataSource.signUp(username, email, password);
      return right(user);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      return right(null);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }
}
