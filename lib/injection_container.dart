import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/src/core/utils/db_helper.dart';
import 'package:todo_list/src/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_list/src/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:todo_list/src/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_list/src/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/src/features/todo/domain/usecases/create_todo.dart';
import 'package:todo_list/src/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_list/src/features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => TodoBloc(createTodo: sl(), getTodos: sl()),
  );

  // Usecases
  sl.registerLazySingleton(
    () => CreateTodo(
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
