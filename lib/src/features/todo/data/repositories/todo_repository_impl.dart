import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../datasources/todo_remote_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> createTodo(Todo todo) async {
    try {
      final localResponse =
          await localDataSource.createTodo(TodoModel.fromObject(todo: todo));

      // final remoteResponse =
      //     await remoteDataSource.createTodo(TodoModel.fromObject(todo: todo));

      return right(localResponse);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final localResponse = await localDataSource.getTodos();
      // final remoteResponse = await remoteDataSource.getTodos();
      return right(localResponse);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTodo(Todo todo) async {
    try {
      final localResponse =
          await localDataSource.updateTodo(TodoModel.fromObject(todo: todo));

      // final remoteResponse =
      //     await remoteDataSource.updateTodo(TodoModel.fromObject(todo: todo));

      return right(localResponse);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(Todo todo) async {
    try {
      final localResponse =
          await localDataSource.deleteTodo(TodoModel.fromObject(todo: todo));

      // final remoteResponse =
      //     await remoteDataSource.deleteTodo(TodoModel.fromObject(todo: todo));

      return right(localResponse);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }
}
