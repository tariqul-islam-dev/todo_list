part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  List<Todo>? todos;

  TodoState({this.todos});

  @override
  List<Object?> get props => [todos];
}

abstract class PickingState extends TodoState {
  PickingState();
}

abstract class LoadingState extends TodoState {
  LoadingState();
}

// ========= Main states ==========
class TodoInitialState extends TodoState {
  TodoInitialState();

  @override
  List<Object> get props => [];
}

class SaveTodoState extends TodoState {
  @override
  List<Object?> get props => [];
}

class GetTodoState extends TodoState {
  GetTodoState({required List<Todo> todos}) : super(todos: todos);

  @override
  List<Object?> get props => [todos];
}

class MakeTodoCompletedState extends GetTodoState {
  final int index;
  MakeTodoCompletedState({required this.index, required List<Todo> todos}) : super(todos: todos);

  @override
  List<Object?> get props => [index, todos];
}

// ========= Loading states =========
class SaveLoadingState extends LoadingState {
  final bool isLoading;

  SaveLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

// ========= Picking states =========
class DatePickingState extends PickingState {
  final String date;

  DatePickingState({required this.date});

  @override
  List<Object?> get props => [date];
}

class TimePickingState extends PickingState {
  final String time;

  TimePickingState({required this.time});

  @override
  List<Object?> get props => [time];
}
