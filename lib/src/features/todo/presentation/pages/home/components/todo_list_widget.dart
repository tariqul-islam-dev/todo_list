import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_list/src/features/todo/presentation/pages/details/details_page.dart';

import '../../../../../../core/utils/helper_functions.dart';
import '../../../../domain/entities/todo.dart';
import 'complete_checkbox_widget.dart';

class TodoListWidget extends StatelessWidget {
  final List<Todo> todos;

  const TodoListWidget({
    required this.todos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  todo.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
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
                      const Icon(Icons.date_range, size: 14),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(dateTimeFromMillisecond(todo.date!)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, size: 14),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        dateTimeFromMillisecond(todo.time!, pattern: "hh:mm a"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: CompleteCheckBoxWidget(index: index, todo: todo),
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailsPage.routeName,
                arguments: todo
              );
            },
          ),
        );
      },
    );
  }
}
