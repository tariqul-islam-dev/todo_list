import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository todoRepository;

  GetTodos({required this.todoRepository});

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) {
    return todoRepository.getTodos();
  }
}
