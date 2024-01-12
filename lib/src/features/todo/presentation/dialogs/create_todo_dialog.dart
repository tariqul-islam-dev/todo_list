import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import 'picker_dialogs.dart';

createTodoDialog(BuildContext ctx) {
  String title = "";
  String description = "";

  return showDialog<void>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (_) {

      return BlocProvider.value(
        value: BlocProvider.of<TodoBloc>(ctx),
        child: AlertDialog(
          title: const Text('Create Todo'),
          content: SizedBox(
            width: MediaQuery.of(ctx).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextField(
                    onChanged: (value) {
                      title = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Title",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Description",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<TodoBloc, TodoState>(
                    buildWhen: (previous, current) =>
                        current is DatePickingState,
                    builder: (ctx, state) {
                      return ListTile(
                        onTap: () async {
                          ctx.read<TodoBloc>().add(
                                DatePickingEvent(
                                  dateTime: datePickerDialog(ctx),
                                ),
                              );
                        },
                        leading: const Icon(Icons.date_range),
                        title: Text(
                          state is DatePickingState ? state.date : "Date",
                        ),
                      );
                    },
                  ),
                  BlocBuilder<TodoBloc, TodoState>(
                    buildWhen: (previous, current) =>
                        current is TimePickingState,
                    builder: (context, state) {
                      return ListTile(
                        onTap: () {
                          ctx.read<TodoBloc>().add(
                                TimePickingEvent(
                                  timeOfDay: timePickerDialog(ctx),
                                ),
                              );
                        },
                        leading: const Icon(Icons.watch_later),
                        title: Text(
                          state is TimePickingState ? state.time : "Time",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [

            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is SaveLoadingState && state.isLoading == true){
                  return const CircularProgressIndicator();
                }

                if (state is SaveTodoState){
                  Navigator.pop(ctx);
                  ctx.read<TodoBloc>().add(GetTodosEvent());
                }

                return Row(
                  children: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        ctx.read<TodoBloc>().add(
                          SaveTodoEvent(
                            title: title,
                            description: description,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            )


          ],
        ),
      );
    },
  );
}
