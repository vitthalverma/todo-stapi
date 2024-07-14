import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';
import 'package:frontend/features/task/domain/repository/task_repository.dart';

class DeleteTaskUsecase implements CoreUsecase<void, DeleteTaskCreds> {
  final TaskRepository taskRepository;

  DeleteTaskUsecase(this.taskRepository);

  @override
  Future<Either<Failure, void>> call(DeleteTaskCreds params) async {
    return await taskRepository.deleteTasks(params.id);
  }
}

class DeleteTaskCreds {
  final String id;

  DeleteTaskCreds({required this.id});
}
