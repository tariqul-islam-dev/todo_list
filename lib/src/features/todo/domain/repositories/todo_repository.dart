import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';
import '../usecases/create_todo.dart';

abstract class TodoRepository{
  Future<Either<Failure, bool>> createTodo(Todo todo);
  Future<Either<Failure, List<Todo>>> getTodos();
}