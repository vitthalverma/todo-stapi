import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';

abstract interface class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();
  Future<Either<Failure, void>> updateTaskCompletion(String id, bool completed);

  Future<Either<Failure, void>> addNewTask(String title, String description);

  Future<Either<Failure, void>> deleteTasks(String id);
}
