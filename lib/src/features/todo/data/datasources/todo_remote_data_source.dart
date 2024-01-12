import '../models/todo_model.dart';

abstract class TodoRemoteDataSource{
  Future<void> createTodo(TodoModel todoModel);
  Future<List<TodoModel>> getTodos();
}