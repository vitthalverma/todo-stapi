import 'package:frontend/core/error/exceptions.dart';
import 'package:frontend/features/task/data/models/task_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract interface class TaskRemoteDataSource {
  Future<List<TaskModel>> fetchTasks();
  Future<void> updateTaskCompletion(String id, bool completed);
  Future<void> addNewTask(String title, String description);
  Future<void> deleteTasks(String id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final GraphQLClient client;
  final List<TaskModel> _taskList = [];

  TaskRemoteDataSourceImpl(this.client);
  @override
  Future<List<TaskModel>> fetchTasks() async {
    try {
      const String query = '''
                query {
          tasks{
            data{
              id
              attributes {
                Title
                Description
                Completed

              }
            }
          }
          }

    ''';
      final QueryResult result = await client.query(
          QueryOptions(document: gql(query), fetchPolicy: FetchPolicy.noCache));

      if (result.hasException) {
        throw NtwkException(result.exception.toString());
      }

      final List tasks = result.data!['tasks']['data'];

      _taskList
        ..clear()
        ..addAll(tasks.map((task) => TaskModel.fromJson(task)).toList());
      print('from fetch :  $_taskList');
      return _taskList;
    } on GraphQLError catch (e) {
      throw NtwkException(e.message);
    }
  }

  @override
  Future<void> updateTaskCompletion(String id, bool completed) async {
    try {
      const String mutation = '''
      mutation UpdateTask(\$id: ID!, \$data: TaskInput!) {
       updateTask(id: \$id, data: \$data) {
       data {
        id
        attributes {
        Completed
        }
      }
    }
       }

       ''';

      final result = await client.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(mutation),
        variables: {
          'id': id,
          "data": {"Completed": completed}
        },
      ));

      if (result.hasException) {
        throw NtwkException(result.exception.toString());
      }

      final updatedTaskData = result.data!['updateTask']['data'];

      final updatedTaskIndex =
          _taskList.indexWhere((task) => task.id == updatedTaskData['id']);

      if (updatedTaskIndex != -1) {
        _taskList[updatedTaskIndex] = _taskList[updatedTaskIndex].copyWith(
          completed: updatedTaskData['attributes']['Completed'],
        );
      }
    } on GraphQLError catch (e) {
      throw NtwkException(e.message);
    }
  }

  @override
  Future<void> addNewTask(String title, String description) async {
    try {
      const String mutation = '''

          mutation createTask(\$data: TaskInput!) {
              createTask( data: \$data) {
                data {
                  id
                  attributes {
                    Title
                    Description
                    Completed
                    publishedAt
                  }
                }
              }
            }
      
          ''';

      final result = await client.mutate(MutationOptions(
          document: gql(mutation),
          fetchPolicy: FetchPolicy.noCache,
          variables: {
            'data': {
              "Title": title,
              "Description": description,
              "Completed": false,
              "publishedAt":
                  "${DateTime.now().toUtc().toIso8601String().split('.')[0]}Z",
            }
          }));

      if (result.hasException) {
        throw NtwkException(result.exception.toString());
      }
      final newTask = result.data!['createTask']['data'];

      _taskList.add(TaskModel.fromJson(newTask));
      print('from update: $_taskList');
    } on GraphQLError catch (e) {
      throw NtwkException(e.message);
    }
  }

  @override
  Future<void> deleteTasks(String id) async {
    try {
      const String mutation = '''

                mutation DeleteTask(\$id: ID!) {
                deleteTask(id: \$id){
              data{
              id
            }
          }
        }       
      
          ''';

      final result = await client.mutate(MutationOptions(
          document: gql(mutation),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"id": id}));

      if (result.hasException) {
        throw NtwkException(result.exception.toString());
      }

      String deletedTaskId = result.data!['deleteTask']['data']['id'];

      _taskList.removeWhere((task) => task.id == deletedTaskId);
      print('from delete : $_taskList');
    } on GraphQLError catch (e) {
      throw NtwkException(e.message);
    }
  }
}
