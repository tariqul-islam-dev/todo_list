import 'package:equatable/equatable.dart';

import '../../features/todo/domain/entities/todo.dart';

class Params extends Equatable {
  final Todo todo;

  const Params({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}
