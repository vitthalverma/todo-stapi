part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class UpdateTaskCompletionEvent extends TaskEvent {
  final String id;
  final bool completed;

  UpdateTaskCompletionEvent(this.id, this.completed);
}

class AddNewTaskEvent extends TaskEvent {
  final String title;
  final String description;

  AddNewTaskEvent({required this.title, required this.description});
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent({required this.id});
}
