import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/time_picker_widget.dart';

createTodoDialog(BuildContext ctx, {Todo? todo}) {
  String title = "";
  String description = "";

  return showDialog<void>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (_) {
      return BlocProvider.value(
        value: BlocProvider.of<TodoBloc>(ctx),
        child: AlertDialog(
          title: Text(todo == null ? 'Create Todo' : 'Edit Todo'),
          content: SizedBox(
            width: MediaQuery.of(ctx).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomTextFormField(
                    onChange: (value) {
                      title = value;
                    },
                    labelText: "Title",
                    initText: todo?.title,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hintText: "Description",
                    maxLines: 3,
                    initText: todo?.description,
                    onChange: (value) {
                      description = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DatePickerWidget(),
                  const TimePickerWidget(),
                ],
              ),
            ),
          ),
          actions: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is SaveLoadingState && state.isLoading == true) {
                  return const CircularProgressIndicator();
                }

                if (state is SaveTodoState) {
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
                        if (todo == null) {
                          ctx.read<TodoBloc>().add(
                                SaveTodoEvent(
                                  title: title,
                                  description: description,
                                ),
                              );
                        } else {
                          ctx.read<TodoBloc>().add(
                                UpdateTodoEvent(
                                  title: title,
                                  description: description,
                                  todo: todo,
                                ),
                              );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
