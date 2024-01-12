import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/core/utils/helper_functions.dart';
import 'package:todo_list/src/features/todo/presentation/dialogs/create_todo_dialog.dart';
import 'package:todo_list/src/features/todo/presentation/dialogs/picker_dialogs.dart';

import '../../bloc/todo_bloc.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(GetTodosEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
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
              return ListView.builder(
                itemCount: state.todos!.length,
                itemBuilder: (context, index) {
                  final todo = state.todos![index];
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title!,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            todo.description!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.date_range, size: 14),
                                SizedBox(width: 2,),
                                Text(dateTimeFromMillisecond(todo.date!)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.access_time, size: 14),
                                SizedBox(width: 2,),
                                Text(dateTimeFromMillisecond(todo.time!,
                                    pattern: "hh:mm a")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: todo.completed,
                        onChanged: (value) {

                        },
                      ),
                      onTap: () {},
                    ),
                  );
                },
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
