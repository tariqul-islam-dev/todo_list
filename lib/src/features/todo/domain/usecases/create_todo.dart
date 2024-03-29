import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/src/features/todo/domain/entities/todo.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/todo_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/todo_repository.dart';

class CreateTodo implements UseCase<void, Params> {
  final TodoRepository todoRepository;

  CreateTodo({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return todoRepository.createTodo(params.todo);
  }
}