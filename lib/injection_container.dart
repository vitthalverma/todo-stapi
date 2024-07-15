import 'package:frontend/core/constants/app_creds.dart';
import 'package:frontend/features/auth/data/auth_remote_data/auth_remote_data_source.dart';
import 'package:frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/respository/auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/task/data/data_source/task_remote_data_source.dart';
import 'package:frontend/features/task/data/repository/task_repo_impl.dart';
import 'package:frontend/features/task/domain/repository/task_repository.dart';
import 'package:frontend/features/task/domain/usecases/add_new_task_usecase.dart';
import 'package:frontend/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:frontend/features/task/domain/usecases/fetch_tasks_usecase.dart';
import 'package:frontend/features/task/domain/usecases/update_task_comp_usecase.dart';
import 'package:frontend/features/task/presentation/bloc/task_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final HttpLink httpLink = HttpLink(strapiGraphqlEndpoint);

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
  final httpClient = http.Client();
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => httpClient);
}

void _initAuth() {
  // Datasource
  sl
    ..registerFactory<TaskRemoteDataSource>(
        () => TaskRemoteDataSourceImpl(sl()))
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )

    // Repository
    ..registerFactory<TaskRepository>(() => TaskRepositoryImpl(sl()))
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()))
    // Usecases
    ..registerFactory(() => FetchTasksUsecase(sl()))
    ..registerFactory(() => UpdateTaskCompletionUsecase(sl()))
    ..registerFactory(() => AddNewTaskUsecase(sl()))
    ..registerFactory(() => DeleteTaskUsecase(sl()))
    ..registerFactory(() => LoginUsecase(sl()))
    ..registerFactory(() => SignUpUsecase(sl()))
    ..registerFactory(() => LogoutUsecase(sl()))

    // Bloc
    ..registerLazySingleton(() => AuthBloc(sl(), sl(), sl()))
    ..registerLazySingleton(
      () => TaskBloc(sl(), sl(), sl(), sl()),
    );
}
