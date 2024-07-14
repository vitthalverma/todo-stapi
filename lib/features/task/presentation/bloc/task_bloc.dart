import 'package:flutter/material.dart';
import 'package:frontend/core/usecase/core_usecase.dart';
import 'package:frontend/features/task/domain/entity/task_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/task/domain/usecases/add_new_task_usecase.dart';
import 'package:frontend/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:frontend/features/task/domain/usecases/fetch_tasks_usecase.dart';
import 'package:frontend/features/task/domain/usecases/update_task_comp_usecase.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchTasksUsecase fetchTasksUsecase;
  final UpdateTaskCompletionUsecase taskCompletionUsecase;
  final AddNewTaskUsecase addNewTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;

  TaskBloc(
    this.fetchTasksUsecase,
    this.taskCompletionUsecase,
    this.addNewTaskUsecase,
    this.deleteTaskUsecase,
  ) : super(TaskInitial()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      final result = await fetchTasksUsecase(NoParams());

      result.fold(
        (l) => emit(TaskErrorState(l.message)),
        (r) => emit(TaskLoadedState(r)),
      );
    });

    on<UpdateTaskCompletionEvent>((event, emit) async {
      emit(TaskLoadingState());
      final result = await taskCompletionUsecase(
          TaskCompletionCreds(id: event.id, completed: event.completed));

      result.fold(
        (l) => emit(TaskErrorState(l.message)),
        (r) => add(LoadTasksEvent()),
      );
    });

    on<AddNewTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      final result = await addNewTaskUsecase(
          AddNewTaskCreds(title: event.title, description: event.description));

      result.fold(
        (l) => emit(TaskErrorState(l.message)),
        (r) => add(LoadTasksEvent()),
      );
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        final result = await deleteTaskUsecase(DeleteTaskCreds(id: event.id));

        result.fold(
          (l) => emit(TaskErrorState(l.message)),
          (_) => add(LoadTasksEvent()), // Trigger fetch after successful delete
        );
      } catch (e) {
        emit(TaskErrorState(e.toString()));
      }
    });
  }
}
