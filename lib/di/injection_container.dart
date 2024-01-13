import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../src/core/utils/db_helper.dart';
import '../src/features/todo/data/datasources/todo_local_data_source.dart';
import '../src/features/todo/data/datasources/todo_remote_data_source.dart';
import '../src/features/todo/data/repositories/todo_repository_impl.dart';
import '../src/features/todo/domain/repositories/todo_repository.dart';
import '../src/features/todo/domain/usecases/create_todo.dart';
import '../src/features/todo/domain/usecases/delete_todo.dart';
import '../src/features/todo/domain/usecases/get_todos.dart';
import '../src/features/todo/domain/usecases/update_todo.dart';
import '../src/features/todo/presentation/bloc/todo_bloc.dart';
import 'onboarding_init.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initOnboarding();

  // Bloc
  sl.registerFactory(
    () => TodoBloc(
      createTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
      getTodos: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(
    () => CreateTodo(
      todoRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UpdateTodo(
      todoRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeleteTodo(
      todoRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetTodos(
      todoRepository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(
      db: sl(),
    ),
  );

  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );

  // Core
  final dbHelper = await DBHelper.instance();
  sl.registerFactory(() => dbHelper);

  // External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
