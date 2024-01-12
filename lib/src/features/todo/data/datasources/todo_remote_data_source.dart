import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<void> createTodo(TodoModel todoModel);

  Future<List<TodoModel>> getTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> createTodo(TodoModel todoModel) {
    // TODO: implement createTodo
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }
}
