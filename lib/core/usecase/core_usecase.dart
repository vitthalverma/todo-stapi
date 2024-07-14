import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';

abstract interface class CoreUsecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
