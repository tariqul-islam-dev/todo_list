import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todo_bloc.dart';
import '../../dialogs/create_todo_dialog.dart';
import 'components/todo_list_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(GetTodosEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TodoBloc>().add(GetTodosEvent());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BlocBuilder<TodoBloc, TodoState>(
            buildWhen: (previous, current) => current is GetTodoState,
            builder: (context, state) {
              if (state.todos == null || state.todos!.isEmpty) {
                return Text(
                  "No todos",
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
              return TodoListWidget(
                todos: state.todos!,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          createTodoDialog(context);
        },
      ),
    );
  }
}
