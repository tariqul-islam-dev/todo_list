import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/todo.dart';
import '../../../bloc/todo_bloc.dart';

class CompleteCheckBoxWidget extends StatelessWidget {
  const CompleteCheckBoxWidget({
    super.key,
    required this.index,
    required this.todo,
  });

  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) =>
      current is MakeTodoCompletedState,
      builder: (context, state) {
        return Checkbox(
          value: todo.completed,
          onChanged: (value) {
            context.read<TodoBloc>().add(
              MakeCompletedEvent(
                index: index,
                isCompleted: value ?? false,
                todo: todo,
              ),
            );
          },
        );
      },
    );
  }
}