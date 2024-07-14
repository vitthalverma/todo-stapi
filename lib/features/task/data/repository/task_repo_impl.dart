import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/error/exceptions.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/features/task/data/data_source/task_remote_data_source.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';
import 'package:frontend/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);
  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    try {
      final taskList = await taskRemoteDataSource.fetchTasks();
      return right(taskList);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTaskCompletion(
      String id, bool completed) async {
    try {
      await taskRemoteDataSource.updateTaskCompletion(id, completed);
      return right(null);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addNewTask(
      String title, String description) async {
    try {
      await taskRemoteDataSource.addNewTask(title, description);

      return right(null);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTasks(String id) async {
    try {
      await taskRemoteDataSource.deleteTasks(id);

      return right(null);
    } on NtwkException catch (e) {
      return left(Failure(e.message));
    }
  }
}
