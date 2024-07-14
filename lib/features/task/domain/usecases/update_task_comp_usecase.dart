import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';
import 'package:frontend/features/task/domain/repository/task_repository.dart';

class UpdateTaskCompletionUsecase
    implements CoreUsecase<void, TaskCompletionCreds> {
  final TaskRepository taskRepository;

  UpdateTaskCompletionUsecase(this.taskRepository);
  @override
  Future<Either<Failure, void>> call(TaskCompletionCreds params) async {
    return await taskRepository.updateTaskCompletion(
        params.id, params.completed);
  }
}

class TaskCompletionCreds {
  final String id;
  final bool completed;

  TaskCompletionCreds({required this.id, required this.completed});
}
