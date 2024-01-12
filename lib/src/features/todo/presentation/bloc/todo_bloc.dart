import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/src/features/todo/domain/usecases/get_todos.dart';

import '../../domain/usecases/create_todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CreateTodo createTodo;
  final GetTodos getTodos;

  TodoBloc({
    required this.createTodo,
    required this.getTodos,
  }) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
