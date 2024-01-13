part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

abstract class PickingEvent extends TodoEvent {
  const PickingEvent();
}

class GetTodosEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

// ========== Picker events ==========
class DatePickingEvent extends PickingEvent {
  final Future<DateTime?> dateTime;

  const DatePickingEvent({required this.dateTime});

  @override
  List<Object?> get props => [dateTime];
}

class TimePickingEvent extends PickingEvent {
  final Future<TimeOfDay?> timeOfDay;

  const TimePickingEvent({required this.timeOfDay});

  @override
  List<Object?> get props => [timeOfDay];
}

// ============ Save btn event ==========
class SaveTodoEvent extends TodoEvent {
  final String title;
  final String description;

  const SaveTodoEvent({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class UpdateTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final Todo todo;

  const UpdateTodoEvent({
    required this.title,
    required this.description,
    required this.todo,
  });

  @override
  List<Object?> get props => [title, description, todo];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  const DeleteTodoEvent({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

// ========== Make completed ========
class MakeCompletedEvent extends TodoEvent {
  final int index;
  final Todo todo;
  final bool isCompleted;

  const MakeCompletedEvent({
    required this.index,
    required this.isCompleted,
    required this.todo,
  });

  @override
  List<Object?> get props => [index, isCompleted, todo];
}
