import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/core/utils/helper_functions.dart';
import 'package:todo_list/src/features/todo/domain/entities/todo.dart';
import 'package:todo_list/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_list/src/features/todo/presentation/dialogs/create_todo_dialog.dart';
import 'package:todo_list/src/features/todo/presentation/widgets/date_picker_widget.dart';
import 'package:todo_list/src/features/todo/presentation/widgets/time_picker_widget.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = "/details";

  final Todo todo;

  const DetailsPage({
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TodoBloc>().add(DeleteTodoEvent(todo: todo));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is ModifiedTodoState){
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    todo.description!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text(dateTimeFromMillisecond(todo.date!)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text(dateTimeFromMillisecond(todo.time!,
                        pattern: "hh:mm a")),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        createTodoDialog(context, todo: todo);
                      },
                      child: const Text("Edit"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
