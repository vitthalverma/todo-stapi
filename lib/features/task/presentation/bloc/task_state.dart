part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> tasks;

  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}
