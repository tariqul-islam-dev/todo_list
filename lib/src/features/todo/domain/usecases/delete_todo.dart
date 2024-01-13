import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/todo_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo implements UseCase<bool, Params> {
  final TodoRepository todoRepository;

  DeleteTodo({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return todoRepository.deleteTodo(params.todo);
  }
}
