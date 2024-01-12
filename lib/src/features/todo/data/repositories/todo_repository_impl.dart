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
      return right(localResponse);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final localResponse = await localDataSource.getTodos();
      return right(localResponse);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }
}
