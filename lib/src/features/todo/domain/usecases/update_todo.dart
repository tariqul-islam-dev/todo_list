import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/todo_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/todo_repository.dart';

class UpdateTodo implements UseCase<bool, Params> {

  final TodoRepository todoRepository;

  UpdateTodo({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return todoRepository.updateTodo(params.todo);
  }

}