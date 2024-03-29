import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/core/usecase/usecase.dart';
import 'package:todo_list/src/core/utils/helper_functions.dart';
import 'package:todo_list/src/core/utils/widgets.dart';
import 'package:todo_list/src/features/todo/domain/entities/todo.dart';
import 'package:todo_list/src/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo_list/src/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_list/src/features/todo/domain/usecases/update_todo.dart';

import '../../../../core/params/todo_params.dart';
import '../../domain/usecases/create_todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CreateTodo createTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final GetTodos getTodos;

  int? date;
  int? time;

  TodoBloc({
    required this.createTodo,
    required this.deleteTodo,
    required this.updateTodo,
    required this.getTodos,
  }) : super(TodoInitialState()) {
    on<GetTodosEvent>((event, emit) async {
      emit(SaveLoadingState(isLoading: true));
      final fetchTodos = await getTodos(NoParams());
      emit(SaveLoadingState(isLoading: false));

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

    on<UpdateTodoEvent>((event, emit) async {
      final String title = event.title;
      final String description = event.description;
      final todo = event.todo;

      if (title.isNotEmpty) {
        todo.title = title;
      }

      if (description.isNotEmpty) {
        todo.description = description;
      }

      if (date != null) {
        todo.date = date;
      }

      if (time != null) {
        todo.time = time;
      }

      emit(SaveLoadingState(isLoading: true));

      print("update todo");
      print(todo);

      final newTodo = await updateTodo(Params(todo: todo));

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
    });

    on<DeleteTodoEvent>((event, emit) async {
      final todo = event.todo;
      emit(SaveLoadingState(isLoading: true));

      print("delete todo");
      print(todo);

      final deletedTodo = await deleteTodo(Params(todo: todo));

      deletedTodo.fold(
        (failure) {
          showToast(message: failure.message);
          emit(SaveLoadingState(isLoading: false));
        },
        (success) {
          showToast(message: 'Success');
          state.todos?.removeWhere((element) => element.id == todo.id);
          emit(ModifiedTodoState());
        },
      );
    });

    on<MakeCompletedEvent>((event, emit) async {
      final Todo todo = event.todo;
      final int index = event.index;
      final bool isCompleted = event.isCompleted;

      final List<Todo> todos = List.from(state.todos!);
      todo.completed = isCompleted;

      emit(SaveLoadingState(isLoading: true));

      final newTodo = await updateTodo(Params(todo: todo));

      newTodo.fold(
        (failure) {
          showToast(message: failure.message);
        },
        (success) {
          todos[index] = todo;

          print("bloc");
          print(todos[index].completed);

          emit(MakeTodoCompletedState(todos: todos));
        },
      );
    });
  }
}
