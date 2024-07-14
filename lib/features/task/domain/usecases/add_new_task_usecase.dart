import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/faliure.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';
import 'package:frontend/features/task/domain/repository/task_repository.dart';

class AddNewTaskUsecase implements CoreUsecase<void, AddNewTaskCreds> {
  final TaskRepository taskRepository;

  AddNewTaskUsecase(this.taskRepository);

  @override
  Future<Either<Failure, void>> call(AddNewTaskCreds params) async {
    return await taskRepository.addNewTask(params.title, params.description);
  }
}

class AddNewTaskCreds {
  final String title;
  final String description;

  AddNewTaskCreds({required this.title, required this.description});
}
