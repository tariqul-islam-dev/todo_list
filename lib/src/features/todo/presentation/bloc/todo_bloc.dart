import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/core/usecase/usecase.dart';
import 'package:todo_list/src/core/utils/helper_functions.dart';
import 'package:todo_list/src/core/utils/widgets.dart';
import 'package:todo_list/src/features/todo/domain/entities/todo.dart';
import 'package:todo_list/src/features/todo/domain/usecases/get_todos.dart';

import '../../domain/usecases/create_todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CreateTodo createTodo;
  final GetTodos getTodos;

  int? date;
  int? time;

  TodoBloc({
    required this.createTodo,
    required this.getTodos,
  }) : super(TodoInitialState()) {
    on<GetTodosEvent>((event, emit) async {
      final fetchTodos = await getTodos(NoParams());

      fetchTodos.fold(
        (failure) => showToast(message: failure.message),
        (success) {
          state.todos = success;

          emit(GetTodoState(todos: state.todos ?? []));
        },
      );
    });

    on<DatePickingEvent>((event, emit) async {
      final dateTime = await event.dateTime;

      if (dateTime == null && date == null) {
        emit(DatePickingState(date: "Select correct date"));
        return;
      }

      if (dateTime != null) {
        date = dateTime.millisecondsSinceEpoch;
      }

      final dateStr = dateTimeFromMillisecond(date!);

      emit(DatePickingState(date: dateStr));
    });

    on<TimePickingEvent>((event, emit) async {
      final timeOfDay = await event.timeOfDay;

      if (timeOfDay == null && time == null) {
        emit(TimePickingState(time: "Select time"));
        return;
      }

      if (timeOfDay != null) {
        final now = DateTime.now();
        final dt = DateTime(
          now.year,
          now.month,
          now.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
        time = dt.millisecondsSinceEpoch;
      }

      final timeStr = dateTimeFromMillisecond(time!, pattern: "hh:mm a");

      emit(TimePickingState(time: timeStr));
    });

    on<SaveTodoEvent>((event, emit) async {
      final String title = event.title;
      final String description = event.description;

      if (title.isEmpty ||
          description.isEmpty ||
          date == null ||
          time == null) {
        showToast(message: "Give me all info");
        return;
      }

      if (date != null && time != null) {
        final Todo todo = Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          description: description,
          date: date,
          time: time,
        );

        emit(SaveLoadingState(isLoading: true));

        print("New todo");
        print(todo);

        final newTodo = await createTodo(Params(todo: todo));

        newTodo.fold(
          (failure) {
            showToast(message: failure.message);
            emit(SaveLoadingState(isLoading: false));
          },
          (success) {
            showToast(message: 'Success');

            emit(SaveTodoState());
          },
        );
      }
    });

    on<MakeCompletedEvent>((event, emit) {
      final Todo todo = event.todo;
      final int index = event.index;
      final bool isCompleted = event.isCompleted;

      final List<Todo> todos = List.from(state.todos!);
      todo.completed = isCompleted;
      todos[index] = todo;
      emit(SaveLoadingState(isLoading: true));
      print("bloc");
      print(todos[index].completed);

      emit(MakeTodoCompletedState(index: index, todos:  todos));
    });
  }


}
