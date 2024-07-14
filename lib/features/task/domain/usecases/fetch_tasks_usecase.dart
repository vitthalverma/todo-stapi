import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';
import 'package:frontend/features/task/domain/repository/task_repository.dart';

class FetchTasksUsecase implements CoreUsecase<List<TaskEntity>, NoParams> {
  final TaskRepository taskRepository;

  FetchTasksUsecase(this.taskRepository);
  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await taskRepository.fetchTasks();
  }
}
