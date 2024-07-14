import 'package:frontend/features/task/domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['attributes']['Title'] ?? '',
      description: json['attributes']['Description'] ?? '',
      completed: json['attributes']['Completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  TaskModel copyWith({bool? completed}) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      completed: completed ?? this.completed,
    );
  }
}
