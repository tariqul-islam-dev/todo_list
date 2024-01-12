import '../models/todo_model.dart';

abstract class TodoLocalDataSource{
  Future<bool> createTodo(TodoModel todoModel);
  Future<List<TodoModel>> getTodos();
}